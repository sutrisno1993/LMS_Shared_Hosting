<?php

use Illuminate\Http\Request;
use Illuminate\Support\Facades\Route;

Route::get('/user', function (Request $request) {
    return $request->user();
})->middleware('auth:sanctum');

Route::post('/v1/sync-all', [App\Http\Controllers\Api\TimetableSyncController::class, 'syncAll']);

Route::middleware('auth:sanctum')->group(function () {
    Route::get('/student/dashboard', [App\Http\Controllers\Api\StudentApiController::class, 'dashboard']);
    Route::post('/student/scan-attendance', [App\Http\Controllers\Api\StudentApiController::class, 'scanAttendance']);
    Route::get('/student/grades', [App\Http\Controllers\Api\StudentApiController::class, 'grades']);
    Route::get('/student/questionnaires', [App\Http\Controllers\Api\StudentApiController::class, 'questionnaires']);
    Route::post('/student/questionnaires/submit', [App\Http\Controllers\Api\StudentApiController::class, 'submitQuestionnaire']);
    Route::get('/student/exam/{id}', [App\Http\Controllers\Api\StudentApiController::class, 'getExam']);
    Route::post('/student/exam/{id}/submit', [App\Http\Controllers\Api\StudentApiController::class, 'submitExamAnswer']);
});
