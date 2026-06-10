#!/bin/bash

BASE_DIR="$HOME/QuanLyTienTrinh"
LOG_DIR="$BASE_DIR/logs"
BACKUP_DIR="$BASE_DIR/backup"
LOG_FILE="$LOG_DIR/monitor.log"

mkdir -p "$LOG_DIR"
mkdir -p "$BACKUP_DIR"

while true
do
    echo "======================"
    echo "1. Xem danh sách tiến trình"
    echo "2. Ghi log tiến trình"
    echo "3. Dừng tất cả tiến trình sleep"
    echo "4. Sao lưu file log"
    echo "5. Thoát"
    echo "======================"

    read -p "Chọn chức năng: " choice

    case $choice in

        1)
            echo "Danh sách tiến trình sleep:"
            ps -ef | grep sleep | grep -v grep
            ;;

        2)
            echo "===== $(date) =====" >> "$LOG_FILE"
            ps -ef | grep sleep | grep -v grep >> "$LOG_FILE"
            echo "" >> "$LOG_FILE"
            echo "Đã ghi log."
            ;;

        3)
            count=$(pgrep -u $USER sleep | wc -l)

            if [ "$count" -gt 0 ]; then
                pkill -u $USER sleep
                echo "Đã dừng $count tiến trình sleep."
            else
                echo "Không có tiến trình sleep nào."
            fi
            ;;

        4)
            if [ -f "$LOG_FILE" ]; then
                tar -czf "$BACKUP_DIR/monitor_$(date +%Y%m%d_%H%M%S).tar.gz" "$LOG_FILE"
                echo "Sao lưu thành công."
            else
                echo "Chưa có file log."
            fi
            ;;

        5)
            echo "Thoát chương trình."
            exit 0
            ;;

        *)
            echo "Lựa chọn không hợp lệ."
            ;;
    esac

done
