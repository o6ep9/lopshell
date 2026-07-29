set -euo pipefail

BAT="BAT0"
SYS="/sys/class/power_supply/${BAT}"
START_FILE="${SYS}/charge_control_start_threshold"
END_FILE="${SYS}/charge_control_end_threshold"

DESK_START=40
DESK_END=60
MOBILE_START=0
MOBILE_END=100

notify() {
    command -v notify-send >/dev/null 2>&1 && notify-send -i battery "Charge mode" "$1"
}

if [[ ! -e "$START_FILE" || ! -e "$END_FILE" ]]; then
    notify "Файлы порогов зарядки не найдены для ${BAT}"
    echo "Не найдено: $START_FILE / $END_FILE" >&2
    exit 1
fi

if [[ ! -w "$START_FILE" || ! -w "$END_FILE" ]]; then
    notify "Нет прав на запись в ${SYS}. Настрой udev/tmpfiles правило."
    echo "Нет прав на запись в $START_FILE / $END_FILE" >&2
    exit 1
fi

current_end=$(cat "$END_FILE")

if (( current_end <= 80 )); then
    echo "$MOBILE_START" > "$START_FILE"
    echo "$MOBILE_END"   > "$END_FILE"
    notify "Mobile mode: ${MOBILE_END}%"
else
    echo "$DESK_START" > "$START_FILE"
    echo "$DESK_END"   > "$END_FILE"
    notify "Desk mode: ${DESK_END}%"
fi
