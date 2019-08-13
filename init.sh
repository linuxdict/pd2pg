#!/bin/sh

# Initial DB
psql $DATABASE_URL < schema.sql

# Refresh Data
/usr/bin/pd2pg
