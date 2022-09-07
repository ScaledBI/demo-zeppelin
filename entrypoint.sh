#!/usr/bin/env bash

set -o errexit
set -o nounset
set -o pipefail

# Retrieve Postgres user and password
# In production you should not hardcode these
export POSTGRES_PASSWORD="password"

sed -i 's|$POSTGRES_USERNAME|'"$SHINYPROXY_USERNAME"'|' /opt/zeppelin/conf/interpreter.json
sed -i 's|$POSTGRES_PASSWORD|'"$POSTGRES_PASSWORD"'|' /opt/zeppelin/conf/interpreter.json

# replace the note id that should be shown
# if empty, the overview is shown
sed -i 's|$ZEPPELIN_NOTEBOOK_HOMESCREEN|'"${ZEPPELIN_NOTEBOOK_HOMESCREEN:-}"'|' /opt/zeppelin/conf/zeppelin-site.xml

# If the notebook is started via a tile the REST-Api call to Zeppelin needs to be adjusted to execute the correct notebook's paragraphs.
# If the notebook is not opened via a tile we call an incomplete endpoint which does not impact the notebook.
sed -i 's|$ZEPPELIN_NOTEBOOK_NAME|'"${ZEPPELIN_NOTEBOOK_HOMESCREEN:-}"'|' start.sh

exec "$@"
