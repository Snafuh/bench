#!/usr/bin/env bash
set -euo pipefail

mkdir -p docs/meta

timestamp=$(date -u +"%Y-%m-%dT%H:%MZ")

get_version() {
    cmd="$1"
    $cmd --version 2>/dev/null || echo "unknown"
}

# Submodule commit hashes
libjxl_commit=$(git rev-parse HEAD:third_party/libjxl 2>/dev/null || echo "not-checked-out")
jxlrs_commit=$(git rev-parse HEAD:third_party/jxl-rs 2>/dev/null || echo "not-checked-out")
jxlatte_commit=$(git rev-parse HEAD:third_party/jxlatte 2>/dev/null || echo "not-checked-out")
j40_commit=$(git rev-parse HEAD:third_party/j40 2>/dev/null || echo "not-checked-out")
conformance_commit=$(git rev-parse HEAD:third_party/conformance 2>/dev/null || echo "not-checked-out")

# Installed binary version for jxl-oxide
jxl_oxide_version=$(get_version "jxl-oxide")

# Write metadata JSON
cat > docs/meta/metadata.json <<EOF
{
  "timestamp": "$timestamp",
  "libjxl_commit": "$libjxl_commit",
  "jxl-rs_commit": "$jxlrs_commit",
  "jxlatte_commit": "$jxlatte_commit",
  "j40_commit": "$j40_commit",
  "conformance_commit": "$conformance_commit",
  "jxl-oxide_version": "$jxl_oxide_version"
}
EOF

echo "✅ Metadata written to docs/meta/metadata.json"
