#!/usr/bin/env bash
# Claude Code statusline: verfügbares Kontingent (5h / 7d) der aktuellen Session.
# Balken = noch verfügbar. ↻ = Restzeit bis Reset des Fensters.
# Erhält Session-JSON via stdin.

input="$(cat)"
NOW=$(date +%s)

# Genutzte Prozente + Reset-Timestamps ziehen (fehlend -> -1)
read -r H5 H5R D7 D7R MODEL <<EOF
$(jq -r '
  [ (.rate_limits.five_hour.used_percentage // -1 | floor),
    (.rate_limits.five_hour.resets_at        // -1 | floor),
    (.rate_limits.seven_day.used_percentage  // -1 | floor),
    (.rate_limits.seven_day.resets_at         // -1 | floor),
    (.model.display_name // "Claude") ]
  | @tsv' <<< "$input" | tr '\t' ' ')
EOF

# ANSI-Farben
RESET=$'\033[0m'; DIM=$'\033[2m'; BOLD=$'\033[1m'
GREEN=$'\033[32m'; YELLOW=$'\033[33m'; RED=$'\033[31m'

# Farbe je nach VERFÜGBAR: viel übrig = grün, wenig = rot
color_for() {
  local avail=$1
  if   (( avail <= 20 )); then printf '%s' "$RED"
  elif (( avail <= 50 )); then printf '%s' "$YELLOW"
  else                         printf '%s' "$GREEN"
  fi
}

# Balken bauen: bar <prozent-gefüllt> <breite>
bar() {
  local pct=$1 width=$2
  (( pct < 0 )) && pct=0
  (( pct > 100 )) && pct=100
  local filled=$(( pct * width / 100 ))
  local empty=$(( width - filled ))
  local col; col=$(color_for "$pct")
  local out="$col"
  local i
  for ((i=0; i<filled; i++)); do out+="█"; done
  out+="$DIM"
  for ((i=0; i<empty; i++)); do out+="░"; done
  out+="$RESET"
  printf '%s' "$out"
}

# Restzeit bis Reset formatieren: fmt_until <unix-ts>
fmt_until() {
  local ts=$1
  (( ts < 0 )) && return
  local diff=$(( ts - NOW ))
  (( diff < 0 )) && diff=0
  local d=$(( diff / 86400 ))
  local h=$(( (diff % 86400) / 3600 ))
  local m=$(( (diff % 3600) / 60 ))
  if   (( d > 0 )); then printf '%dd%dh left' "$d" "$h"
  elif (( h > 0 )); then printf '%dh%dm left' "$h" "$m"
  else                   printf '%dm left' "$m"
  fi
}

# Reset-Zeitpunkt als Uhrzeit formatieren: fmt_clock <unix-ts>
fmt_clock() {
  local ts=$1
  (( ts < 0 )) && return
  date -r "$ts" +%H:%M
}

# segment <label> <genutzt-prozent> <reset-ts> [show-clock]
segment() {
  local label=$1 used=$2 reset_ts=$3 show_clock=${4:-0}
  local avail=$(( 100 - used ))
  local reset; reset=$(fmt_until "$reset_ts")
  printf '%b%s%b %s %b%d%%%b' "$DIM" "$label" "$RESET" "$(bar "$avail" 10)" "$BOLD" "$avail" "$RESET"
  [ -n "$reset" ] && printf ' %b·%b %b%s%b' "$DIM" "$RESET" "$DIM" "$reset" "$RESET"
  (( show_clock )) && { local clock; clock=$(fmt_clock "$reset_ts"); [ -n "$clock" ] && printf ' %b·%b %b↻ %s%b' "$DIM" "$RESET" "$DIM" "$clock" "$RESET"; }
}

segments=()
(( H5 >= 0 )) && segments+=( "$(segment "5h" "$H5" "$H5R" 1)" )
(( D7 >= 0 )) && segments+=( "$(segment "7d" "$D7" "$D7R")" )
segments+=( "$(printf '%b%s%b' "$DIM" "$MODEL" "$RESET")" )

# Mit Trenner ausgeben
sep="  ${DIM}│${RESET}  "
out=""
for i in "${!segments[@]}"; do
  (( i > 0 )) && out+="$sep"
  out+="${segments[$i]}"
done
printf '%s' "$out"
