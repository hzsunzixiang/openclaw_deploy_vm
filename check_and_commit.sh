#!/bin/bash
# 自动提交脚本 - 智能感知内容
export GIT_DIR=/home/ericksun/.openclaw/.git
export GIT_WORK_TREE=/home/ericksun/.openclaw

cd /home/ericksun/.openclaw || exit 1

# 获取变更摘要
changes=$(git diff --name-only)
new_files=$(git diff --name-only --diff-filter=A)
modified_files=$(git diff --name-only --diff-filter=M)
deleted_files=$(git diff --name-only --diff-filter=D)

# 构建提交信息
commit_msg="自动提交: $(date +'%Y-%m-%d %H:%M')\n\n变更详情:\n"
[ -n "$new_files" ] && commit_msg+="🆕 新增: $new_files\n"
[ -n "$modified_files" ] && commit_msg+="✏️ 修改: $modified_files\n"
[ -n "$deleted_files" ] && commit_msg+="🗑️ 删除: $deleted_files\n"

# 执行提交（仅当有变更时）
if [ -n "$changes" ]; then
  git add .
  git commit -m "$commit_msg" &&
  git push origin main
fi