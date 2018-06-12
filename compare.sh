#!/bin/sh -e

pt-table-sync --print --user root --password root h=localhost,D=example,t=guest h=localhost,D=example2,t=guest
