# Claude Code Notify

Get desktop notifications when Claude Code requests tool execution permission or completes tasks.

![Notification Example](notification-example.png)

## Features

- 🔔 Simple desktop notifications for Claude Code interactions
- 🎵 Different notification sounds (Ping for tool requests, Glass for completions)
- 🍎 Native macOS integration

## Installation

```bash
npm install -g claude-code-notify
```

## Setup

### 1. Enable Notification Permissions

Allow AppleScript to send notifications:

1. Open **System Settings** → **Notifications**
2. Find and select **Script Editor** from the list
3. Ensure "Allow Notifications" is checked
4. Configure notification style (Banner or Alert)
5. Test with: `osascript -e "display notification \"Test\" with title \"Test\""`

### 2. Configure Claude Code Hook

Add the notification hook to your Claude Code settings file (`~/.claude/settings.json`).
For more details, see: https://docs.anthropic.com/en/docs/claude-code/hooks

```json
{
  "hooks": {
    "Notification": [
      {
        "type": "command",
        "command": "claude-code-notify"
      }
    ]
  }
}
```

## Notification Types

The script provides simple, clear notifications:

- **Tool Execution Requests**: When Claude asks for permission to execute commands

  - Sound: Ping
  - Message: "🔧 Tool execution pending"

- **Task Completion**: When Claude completes a response
  - Sound: Glass
  - Message: "✅ Response completed"

## Requirements

- macOS (uses `osascript` for notifications)
- Claude Code with hooks functionality
- Bash shell

## How It Works

1. Claude Code executes the notification script via hooks
2. Script finds the latest conversation file in `~/.claude/projects`
3. Determines notification type based on message content
4. Displays native macOS notification with appropriate sound

## License

MIT
