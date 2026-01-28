#!/bin/sh
set -e

echo "Activating feature 'dbt-fusion'"

VERSION=${VERSION:-latest}
echo "Installing dbt-fusion version: $VERSION"

# Install dbt-fusion using the official installation script
# If VERSION is 'latest', use --update flag for the latest version
# Otherwise, pass the specific version number
echo "Downloading and installing dbt-fusion..."
if [ "$VERSION" = "latest" ]; then
    curl -fsSL https://public.cdn.getdbt.com/fs/install/install.sh | sh -s -- --update
else
    curl -fsSL https://public.cdn.getdbt.com/fs/install/install.sh | sh -s -- "$VERSION"
fi

# Verify installation
if command -v dbt >/dev/null 2>&1; then
    echo "dbt-fusion installed successfully"
    dbt --version
else
    echo "ERROR: dbt-fusion installation failed"
    exit 1
fi

echo "Done!"
