// SPDX-License-Identifier: MIT
pragma solidity >=0.4.22 <0.9.0;

/**
 * TodoList 合约用于管理任务列表
 */
contract TodoList {
    // 任务计数器，用于唯一标识每个任务
    uint public taskCount = 0;

    // 任务结构体，包含任务的id、名称和完成状态
    struct Task {
        uint id;
        string taskname;
        bool status;
    }

    // 通过任务ID映射到任务对象
    mapping(uint => Task) public tasks;

    // 当创建新任务时触发的事件
    event TaskCreated(
        uint id,
        string taskname,
        bool status
    );

    // 当任务状态改变时触发的事件
    event TaskStatus(
        uint id,
        bool status
    );

    // 合约构造函数，初始化时创建一个默认任务
    constructor() {
        createTask("Todo List Tutorial");
    }

    // 创建新任务的函数
    function createTask(string memory _taskname) public {
        // 增加任务计数器
        taskCount ++;
        // 创建并存储新任务
        tasks[taskCount] = Task(taskCount, _taskname, false);
        // 触发任务创建事件
        emit TaskCreated(taskCount, _taskname, false);
    }

    // 切换任务状态的函数
    function toggleStatus(uint _id) public {
        // 从映射中获取任务
        Task memory _task = tasks[_id];
        // 切换任务状态
        _task.status = !_task.status;
        // 更新映射中的任务
        tasks[_id] = _task;
        // 触发任务状态改变事件
        emit TaskStatus(_id, _task.status);
    }
}
