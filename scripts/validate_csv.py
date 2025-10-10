#!/usr/bin/env python3
"""
CSV格式验证脚本
用于验证国际化CSV文件的格式是否正确

使用方法:
python3 scripts/validate_csv.py assets_dev/i18n.csv
"""

import csv
import sys
import os


def validate_csv_format(filename):
    """验证CSV文件格式"""
    if not os.path.exists(filename):
        print(f"错误：文件 '{filename}' 不存在")
        return False

    errors = []
    warnings = []

    try:
        with open(filename, 'r', encoding='utf-8') as f:
            reader = csv.reader(f)
            rows = list(reader)

        if len(rows) == 0:
            print("错误：CSV文件为空")
            return False

        # 检查表头
        header = rows[0]
        expected_columns = 15  # keys + 14种语言
        if len(header) != expected_columns:
            errors.append(f"表头列数错误：期望 {expected_columns} 列，实际 {len(header)} 列")
            errors.append(f"表头内容：{header}")

        print(f"表头验证：{len(header)} 列 ✓")

        # 检查数据行
        for i, row in enumerate(rows[1:], 1):  # 从第2行开始（跳过表头）
            if len(row) != expected_columns:
                errors.append(f"第 {i+1} 行：期望 {expected_columns} 列，实际 {len(row)} 列")
                if len(row) > 0:
                    errors.append(f"  键名：{row[0]}")
                else:
                    errors.append("  空行")

            # 检查是否有未匹配的双引号
            for col_num, cell in enumerate(row):
                if cell.count('"') % 2 != 0:
                    errors.append(f"第 {i+1} 行，第 {col_num + 1} 列：双引号不匹配")
                    errors.append(f"  内容：{cell[:50]}...")

            # 检查是否包含制表符或其他特殊字符
            for col_num, cell in enumerate(row):
                if '\t' in cell:
                    warnings.append(f"第 {i+1} 行，第 {col_num + 1} 列：包含制表符")
                if '\n' in cell or '\r' in cell:
                    warnings.append(f"第 {i+1} 行，第 {col_num + 1} 列：包含换行符")

        # 报告结果
        if errors:
            print("\n❌ CSV格式错误：")
            for error in errors[:10]:  # 只显示前10个错误
                print(f"  {error}")
            if len(errors) > 10:
                print(f"  ...还有 {len(errors) - 10} 个错误")
            return False

        if warnings:
            print("\n⚠️  CSV格式警告：")
            for warning in warnings[:5]:  # 只显示前5个警告
                print(f"  {warning}")
            if len(warnings) > 5:
                print(f"  ...还有 {len(warnings) - 5} 个警告")

        total_rows = len(rows) - 1  # 减去表头行
        print(f"\n✅ CSV格式验证通过！")
        print(f"   总行数：{total_rows}")
        print(f"   每行列数：{expected_columns}")
        print(f"   支持语言数：{expected_columns - 1}")
        return True

    except Exception as e:
        print(f"读取CSV文件时出错：{e}")
        return False


def main():
    if len(sys.argv) != 2:
        print("使用方法：python3 scripts/validate_csv.py <csv_file>")
        print("示例：python3 scripts/validate_csv.py assets_dev/i18n.csv")
        sys.exit(1)

    csv_file = sys.argv[1]
    success = validate_csv_format(csv_file)

    sys.exit(0 if success else 1)


if __name__ == "__main__":
    main()
