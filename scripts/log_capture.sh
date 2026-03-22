#!/usr/bin/env bash
set -Eeuo pipefail

OUTPUT_DIR="${1:-output}"
TIMESTAMP="$(date +%F_%H%M%S)"
mkdir -p "$OUTPUT_DIR"
REPORT="$OUTPUT_DIR/log_capture_${TIMESTAMP}.txt"

have_cmd() {
  command -v "$1" >/dev/null 2>&1
}

append_section() {
  local title="$1"
  {
    printf '\n============================================================\n'
    printf '%s\n' "$title"
    printf '============================================================\n'
  } >> "$REPORT"
}

run_cmd() {
  local label="$1"
  shift
  {
    printf '\n$ %s\n' "$*"
    "$@"
  } >> "$REPORT" 2>&1 || {
    printf 'Command failed: %s\n' "$*" >> "$REPORT"
  }
}

{
  printf 'BCBC Technician Tools - Log Capture Report\n'
  printf 'Generated: %s\n' "$(date)"
  printf 'Hostname: %s\n' "$(hostname 2>/dev/null || echo unknown)"
  printf 'User: %s\n' "$(whoami 2>/dev/null || echo unknown)"
} > "$REPORT"

append_section "SYSTEM OVERVIEW"
run_cmd "Date" date
run_cmd "Uptime" uptime
run_cmd "Kernel" uname -a
if have_cmd lsb_release; then
  run_cmd "Distribution" lsb_release -a
elif [[ -f /etc/os-release ]]; then
  run_cmd "OS Release" cat /etc/os-release
fi

append_section "STORAGE"
run_cmd "Disk usage" df -h
if have_cmd lsblk; then
  run_cmd "Block devices" lsblk -o NAME,SIZE,FSTYPE,TYPE,MOUNTPOINTS
fi

append_section "MEMORY AND CPU"
if have_cmd free; then
  run_cmd "Memory" free -h
fi
if have_cmd top; then
  {
    printf '\n$ top -b -n 1 | head -40\n'
    top -b -n 1 | head -40
  } >> "$REPORT" 2>&1 || true
fi
if have_cmd ps; then
  {
    printf '\n$ ps aux --sort=-%%mem | head -15\n'
    ps aux --sort=-%mem | head -15
  } >> "$REPORT" 2>&1 || true
fi

append_section "NETWORK"
if have_cmd ip; then
  run_cmd "IP addresses" ip addr
  run_cmd "Routes" ip route
fi
if have_cmd ss; then
  run_cmd "Listening sockets" ss -tulpn
elif have_cmd netstat; then
  run_cmd "Listening sockets" netstat -tulpn
fi

append_section "RECENT SYSTEM LOGS"
if have_cmd journalctl; then
  {
    printf '\n$ journalctl -n 200 --no-pager\n'
    journalctl -n 200 --no-pager
  } >> "$REPORT" 2>&1 || printf 'journalctl not accessible without elevated permissions\n' >> "$REPORT"
else
  printf 'journalctl not found\n' >> "$REPORT"
fi

append_section "KERNEL MESSAGES"
if have_cmd dmesg; then
  {
    printf '\n$ dmesg | tail -200\n'
    dmesg | tail -200
  } >> "$REPORT" 2>&1 || printf 'dmesg not accessible without elevated permissions\n' >> "$REPORT"
else
  printf 'dmesg not found\n' >> "$REPORT"
fi

append_section "TAILSCALE"
if have_cmd tailscale; then
  run_cmd "Tailscale status" tailscale status
  run_cmd "Tailscale IPv4" tailscale ip -4
else
  printf 'tailscale command not found\n' >> "$REPORT"
fi

append_section "DONE"
printf 'Report saved to %s\n' "$REPORT" | tee -a "$REPORT"
