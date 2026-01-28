#!/bin/sh
set -e

echo "Activating feature 'dbt-fusion'"

VERSION=${VERSION:-latest}
echo "Installing dbt-fusion version: $VERSION"

# The 'install.sh' entrypoint script is always executed as the root user.
#
# These following environment variables are passed in by the dev container CLI.
# These may be useful in instances where the context of the final 
# remoteUser or containerUser is useful.
# For more details, see https://containers.dev/implementors/features#user-env-var
echo "The effective dev container remoteUser is '$_REMOTE_USER'"
echo "The effective dev container remoteUser's home directory is '$_REMOTE_USER_HOME'"

echo "The effective dev container containerUser is '$_CONTAINER_USER'"
echo "The effective dev container containerUser's home directory is '$_CONTAINER_USER_HOME'"

# Install dbt-fusion using the official installation script
# The --update flag ensures the latest version is installed
echo "Downloading and installing dbt-fusion..."
curl -fsSL https://public.cdn.getdbt.com/fs/install/install.sh | sh -s -- --update

# Verify installation
if command -v dbt >/dev/null 2>&1; then
    echo "dbt-fusion installed successfully"
    dbt --version
else
    echo "ERROR: dbt-fusion installation failed"
    exit 1
fi

echo "Done!"
