#!/bin/sh
set -e

# Copy .env if it doesn't exist
if [ ! -f /var/www/.env ]; then
    echo "Creating .env from .env.docker..."
    cp /var/www/.env.docker /var/www/.env
fi

# Generate app key if not set
if grep -q "^APP_KEY=$" /var/www/.env; then
    echo "Generating application key..."
    php artisan key:generate --force
fi

# Wait for MySQL to be ready
echo "Waiting for MySQL connection..."
until php -r "
    try {
        \$conn = new PDO(
            sprintf('mysql:host=%s;port=%s;dbname=%s', getenv('DB_HOST'), getenv('DB_PORT') ?: 3306, getenv('DB_DATABASE')),
            getenv('DB_USERNAME'),
            getenv('DB_PASSWORD')
        );
        echo 'MySQL is ready!' . PHP_EOL;
        exit(0);
    } catch (PDOException \$e) {
        exit(1);
    }
"; do
    echo "MySQL not ready yet, retrying in 3s..."
    sleep 3
done

# Run migrations
echo "Running migrations..."
php artisan migrate --force

# Clear caches
php artisan config:clear
php artisan route:clear
php artisan view:clear

echo "Application is ready."

exec "$@"
