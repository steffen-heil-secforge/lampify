## lampify

> Based on the original [Lampify](https://github.com/MasterDevX/lampify) by [MasterDevX](https://github.com/MasterDevX)

A CLI tool to control Bluetooth Low Energy (BLE) lamps using the LampSmart Pro protocol via BLE advertising.

## Features

- Turn lamp on/off
- Set brightness and color temperature with raw cold/warm byte control
- Support for multiple lamps via device ID
- Pair with lamps using setup command

## How It Works

The lamp accepts two bytes: **cold** (0-255) and **warm** (0-255):
- `cold` - Amount of cold (blue-ish) light
- `warm` - Amount of warm (yellow-ish) light
- Total brightness = cold + warm
- Color temperature = ratio between cold and warm

**Warning:** Values below 3 cause lamp failure requiring power cycle! The tool automatically clamps values to the safe range (3-255).

Examples:
| Setting | Cold | Warm | Result |
|---------|------|------|--------|
| Max brightness, neutral | 255 | 255 | Brightest possible |
| Max brightness, cold | 255 | 3 | Full cold light |
| Max brightness, warm | 3 | 255 | Full warm light |
| 50% brightness, neutral | 128 | 128 | Medium neutral |
| Minimum | 3 | 3 | Dimmest possible |

## Lamp Compatibility

Compatible with BLE lamps controlled via these Android apps:
- [LampSmart Pro](https://play.google.com/store/apps/details?id=com.jingyuan.lamp)
- [FanLamp Pro](https://play.google.com/store/apps/details?id=com.jingyuan.fan_lamp)
- [ApplianceSmart](https://play.google.com/store/apps/details?id=com.jingyuan.smart_home)
- [Vmax smart](https://play.google.com/store/apps/details?id=com.jingyuan.vmax_smart)
- [FanLamp](https://play.google.com/store/apps/details?id=com.fan.lamp)
- [ControlSwitch](https://play.google.com/store/apps/details?id=com.alllink.power_switch)
- [Lamp Smart Pro-Soft Lighting](https://play.google.com/store/apps/details?id=com.alllink.smart_lighting)

## Dependencies

- **Debian / Ubuntu:** `libbluetooth-dev libnotify-dev make gcc`
- **Arch Linux:** `bluez-libs libnotify make gcc`

## Compilation

```bash
git clone https://github.com/yourusername/lampify.git
cd lampify
make
```

To install (places executable in /usr/local/bin with capabilities):
```bash
sudo make install
```

To uninstall:
```bash
sudo make uninstall
```

## Usage

```
lampify [options] <device_id> <command> [args]

Options:
  -n, --notify     Show desktop notifications
  -s, --silent     Suppress non-error output

Commands:
  setup              Pair with lamp (within 5s of power-on)
  on                 Turn lamp on
  off                Turn lamp off
  set <cold> <warm>  Set light levels (3-255 each)
```

### Initial Setup

Before controlling your lamp, pair it:

1. Turn the lamp on using the power switch
2. Within 5 seconds, run:
   ```bash
   lampify lamp1 setup
   ```
3. The lamp should flash to confirm pairing

Each device ID (e.g., `lamp1`, `lamp2`) creates a unique CRC16-based identifier, allowing independent control of multiple lamps.

### Examples

```bash
# Pair with lamp
lampify lamp1 setup

# Turn on
lampify lamp1 on

# Max brightness, neutral color
lampify lamp1 set 255 255

# Max brightness, cold (blue-ish)
lampify lamp1 set 255 3

# Max brightness, warm (yellow-ish)
lampify lamp1 set 3 255

# 50% brightness, neutral
lampify lamp1 set 128 128

# Turn off
lampify lamp1 off

# With desktop notification
lampify -n lamp1 set 200 100
```
