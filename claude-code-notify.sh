#!/usr/bin/env bash

# Claude Code Hooks Notification Script
# Notification script utilizing Claude Code hooks functionality

readonly BASE_DIR="$HOME/.claude"
readonly PROJECTS_DIR="$BASE_DIR/projects"

readonly ASSISTANT_ICON="🤖"
readonly TOOL_PENDING_MSG="🔧 Tool execution pending"
readonly RESPONSE_COMPLETED_MSG="✅ Response completed"
readonly PING_SOUND="Ping"
readonly GLASS_SOUND="Glass"

send_notification() {
    local title="$1"
    local message="$2"
    local sound="$3"
    
    osascript -e "display notification \"$message\" with title \"$title\" sound name \"${sound:-$PING_SOUND}\"" 2>/dev/null
}

get_project_name() {
    local file_path="$1"
    
    [[ ! -f "$file_path" ]] && echo "Unknown project" && return
    
    local project_dir=$(dirname "$file_path")
    local project_name=$(basename "$project_dir")
    
    local username=$(whoami)
    echo "$project_name" | sed "s/^-Users-$username-//" | sed 's/-/ /g'
}

main() {
    # Get the latest JSONL file (sorted by modification time)
    local latest_file=$(find "$PROJECTS_DIR" -name "*.jsonl" -type f -exec ls -t {} + 2>/dev/null | head -n 1)
    [[ -z "$latest_file" ]] && exit 1
    
    # Get the last line of the latest file
    local last_line=$(tail -n 1 "$latest_file" 2>/dev/null)
    [[ -z "$last_line" ]] && exit 1
    
    local project_name=$(get_project_name "$latest_file")
    if echo "$last_line" | grep -q '"type":"tool_use"'; then
        send_notification "$ASSISTANT_ICON $project_name" "$TOOL_PENDING_MSG" "$PING_SOUND"
    else
        send_notification "$ASSISTANT_ICON $project_name" "$RESPONSE_COMPLETED_MSG" "$GLASS_SOUND"
    fi
}

main