# ResearchLoop Kit

ResearchLoop Kit 是一套通用 AI 研究框架，用于长期、可沉淀、以证据为核心的研究任务。
它不绑定某一个领域。用户填写研究简报后，代理会加载状态、审阅证据、检验假设或备选方案、执行研究动作、评估结果，并为下一轮保存检查点。

英文 README: [README.md](README.md)

## 为什么需要它

很多研究提示词会越写越臃肿，因为它们把领域事实、运行环境、实验流程、输出格式和记忆规则全塞进一个文件。这个项目把这些职责拆开：

- `AGENTS.md` 定义代理行为。
- `templates/RESEARCH_BRIEF.template.md` 承载领域输入。
- `templates/*` 保存可复用的产出格式。
- `state/` 保存长期研究记忆。
- `artifacts/` 保存报告、计划、结果日志和溯源记录。

代理专用技能包有意不包含在这个公开仓库中。请通过代理支持的项目指令机制直接加载 `AGENTS.md`。

## 快速开始

1. 复制模板，但不覆盖已有研究简报：

   ```bash
   if [ -L RESEARCH_BRIEF.md ]; then
     echo "RESEARCH_BRIEF.md is a symlink; refusing to continue."
     exit 1
   elif [ ! -e RESEARCH_BRIEF.md ]; then
     cp templates/RESEARCH_BRIEF.template.md RESEARCH_BRIEF.md
   elif [ -f RESEARCH_BRIEF.md ]; then
     echo "RESEARCH_BRIEF.md already exists; leaving it unchanged."
   else
     echo "RESEARCH_BRIEF.md is not a regular file; refusing to continue."
     exit 1
   fi
   ```

2. 填写研究领域、问题、数据来源、成功指标、约束和交付物。

3. 从仓库根目录启动代理，并用它支持的项目指令机制加载 `AGENTS.md`：

   **OpenAI Codex:**

   ```bash
   codex
   ```

   Codex 会自动发现仓库中的 `AGENTS.md`。

   **Claude Code:**

   ```bash
   claude --append-system-prompt-file AGENTS.md
   ```

   **其他代理：** 按工具支持的方式加载 `AGENTS.md`。

4. 每次迭代把输出保存到 `state/` 和 `artifacts/`。

5. 发布前运行结构检查：

   ```bash
   bash scripts/verify.sh
   ```

   该命令检查框架结构和发布安全；具体研究项目是否就绪，由已填写的研究简报和 `AGENTS.md` 约定决定。

## 核心循环

每次迭代包含八个阶段：

<!-- research-loop-phases:start -->

1. 确认执行模式，加载研究简报和历史状态。
2. 锁定一个可衡量目标及其验收标准。
3. 审阅最小必要证据集，并标明结论依据。
4. 提出可检验假设、决策备选项，或明确本轮要缩小的不确定性。
5. 选择最可能改变下一步决策的最小动作。
6. 在研究简报授权和限额内执行。
7. 对照验收标准，以及适用的 baseline 或历史最佳结果评估。
8. 保存并核验检查点，然后设置下一步动作或终止状态。

<!-- research-loop-phases:end -->

## Goal 模式

ResearchLoop Kit 不绑定供应商，无论运行时是否原生支持持续目标状态都可以使用：

- 默认是单轮模式，完成一轮后把控制权交还给用户。
- 只有用户明确授权，并给出可衡量的验收标准、停止条件、最大迭代次数和其他适用限额时，才进入 Goal 模式。
- Goal 模式下每一轮仍必须保存状态并通过完成检查，才能开始下一轮。
- 原生支持持续目标状态的运行时只能镜像公开目标及状态，不能因此扩大范围、权限或预算。
- 比较状态前，应把供应商状态映射为六种标准 Goal 状态；无法识别的状态应暂停并等待确认。
- 继续执行前，应核对运行时状态和 `state/goal.md`；任一处显示授权已撤回或状态非
  `active`，都优先于过期的 `active` 状态。
- Goal 状态中的研究序列 ID 和简报版本必须与当前简报一致；简报发生实质变更或授权到期复核时，应暂停并重新取得授权。
- 默认只允许一个执行者写同一 Goal 检查点；并发执行必须由外部系统提供锁或原子比较更新，并能原子预留外部动作 ID。
- 其他运行时使用 `templates/GOAL_STATE.template.md` 创建
  `state/goal.md`，作为可恢复检查点。
- 只有验收标准得到证据支持时才能标记完成。停止条件触发或限额耗尽时，状态应为 `stopped`。
- 临时由用户暂停时使用 `paused`，缺少外部依赖时使用 `blocked`，用户撤回授权时使用 `cancelled`。
- 对不能安全重放的外部动作，应在执行前以 `planned` 状态记录动作 ID，执行后再记录回执；结果不确定时先核对外部状态，再决定是否重试。

## 研究完整性

- 最终或可复用产出应包含溯源记录：接受或拒绝的来源、数据版本、命令、原始产物路径和核验状态。
- 除非研究简报明确允许，合成、仿真、模拟、随机或示例数据只能用于冒烟测试，不能支撑研究结论。
- 优化类工作应先建立基线，并在固定预算或可比条件下比较结果。
- 大型或可恢复工作应把计划和原始笔记保存到 `artifacts/`，不要只依赖聊天上下文。
- 保存可复用产出前，执行 `AGENTS.md` 中的产物安全规则和
  `templates/PROVENANCE.template.md` 中的发布检查。

设计原则和取舍见 [`docs/design-principles.md`](docs/design-principles.md)，公开参考来源见
[`docs/reference-notes.md`](docs/reference-notes.md)。

## 目录结构

```text
research-loop-kit/
|-- AGENTS.md
|-- README.md
|-- README.zh-CN.md
|-- docs/
|-- templates/
|   |-- RESEARCH_BRIEF.template.md
|   |-- GOAL_STATE.template.md
|   |-- ITERATION_REPORT.template.md
|   |-- EVIDENCE_NOTE.template.md
|   |-- EXPERIMENT_CARD.template.md
|   `-- PROVENANCE.template.md
|-- state/
|-- artifacts/
`-- scripts/verify.sh
```

## 需要改哪里

大多数项目只需要编辑这些文件：

- `RESEARCH_BRIEF.md`：当前研究问题与约束。
- `state/research_log.md`：迭代历史。
- `state/leaderboard.md`：最佳结果或最强发现。
- `state/open_questions.md`：未解决问题。
- `state/decision_log.md`：需要长期保留的决策和证据。
- `state/source_index.md`：可复用来源和数据溯源记录。
- `state/goal.md`：明确启用 Goal 模式后的状态和检查点。

不要为了每个领域频繁修改 `AGENTS.md`。如果指令需要不断加入领域细节，应把这些内容移到研究简报或独立参考文件中。
