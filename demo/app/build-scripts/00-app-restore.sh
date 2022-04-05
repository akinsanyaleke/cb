#!/bin/sh

# lists, searches and extracts only required directories (docs, git, hg, src, svn and acl.svn)
set -e -x
cd ${ENV_APP_DATA_DIR}
tar xvf "/tmp/${ENV_APP_DUMP_LOCAL}" $(tar tf /tmp/${ENV_APP_DUMP_LOCAL} | grep -E 'codebeamer/repository/(docs|git|hg|src|svn|acl.svn)/$')

