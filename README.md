

<img width="1536" height="1024" alt="bcbc-tt-and-ls-header-logos" src="https://github.com/user-attachments/assets/17b0016d-fad2-44e3-a5ee-e612ea4159fe" />
# BCBC Technician Tools and Learning System

A beginner-friendly starter repository for technician tools, log capture, guided troubleshooting, and a simple GitHub Pages landing page.

## Included

- Basic Linux log capture script
- GitHub Pages-ready `index.html`
- Shared project styling in `style.css`
- USB SSD launcher preview page
- Output folder for collected reports
- Notes for next tools to add
- GitHub Pages setup guide

## First tool

The first working tool is `scripts/log_capture.sh`.

It collects:

- Hostname and current user
- Date and uptime
- Kernel and OS details
- Disk usage and mounted filesystems
- Memory summary
- Top processes by memory
- Recent `journalctl` entries (if available)
- Recent kernel messages via `dmesg` (if permitted)
- Basic network information (`ip addr`, `ip route`, `ss -tulpn` when available)
- Tailscale status when installed

## How to run

From the repo folder:

```bash
chmod +x scripts/log_capture.sh
./scripts/log_capture.sh
```

Or save to a custom folder:

```bash
./scripts/log_capture.sh /path/to/output-folder
```

## Output

The script creates a timestamped report in the `output/` folder by default.

Example:

```text
output/log_capture_2026-03-22_153000.txt
```

## GitHub Pages files

- `index.html` → main public landing page
- `style.css` → shared styling
- `usb-menu-preview.html` → preview page for the future USB SSD interface
- `docs/github_pages_setup.md` → step-by-step Pages setup notes

## Good next additions

- SMART drive health check tool
- Backup/sync helper
- Network diagnostics script
- Guided menu launcher
- JSON export mode

## Notes

Some sections may need `sudo` for fuller results depending on your Linux distro and permissions.
---

## Infrastructure Support

Special thank you to **ClouDNS** for supporting reliable DNS infrastructure for BCBC projects.


<img width="96" height="48" alt="cloudns-logo-crop" src="https://github.com/user-attachments/assets/3d379a71-292a-4dec-9703-635c809c22e5" />
