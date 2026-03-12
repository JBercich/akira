#!/bin/bash
set -e

COMMAND="${1:-}"
MODEL="${2:-"qwen3:1.7b"}"

case "$COMMAND" in
    start)
        echo "Starting Ollama model: $MODEL"
        if ! ollama list | grep -q "^$MODEL"; then
            echo "Error: Model '$MODEL' not found. Available models:"
            ollama list
            exit 1
        fi
        nohup ollama run "$MODEL" > /dev/null 2>&1 &
        echo "Model '$MODEL' started in background (PID: $!)"
        ;;
    stop)
        echo "Stopping Ollama model: $MODEL"
        ollama stop "$MODEL" || echo "Failed to stop model '$MODEL'"
        ;;
    *)
        echo "Usage: $0 {start|stop} [model_name]"
        echo "  start [model_name]  - Start a model (default: qwen3:1.7b)"
        echo "  stop [model_name]   - Stop a model (default: qwen3:1.7b)"
        exit 1
        ;;
esac