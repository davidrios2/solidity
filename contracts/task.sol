// SPDX-License-Identifier: MIT
pragma solidity ^0.8.6;

contract TaskCRUD { //create, delete, update and read task on a course

    struct Task {
        uint256 id;
        string name;
        string description;
        uint index;
        bool isDone;
        uint256 timeStamp;
    }
  
    mapping(uint256 => Task) public tasks;
    uint256[] private taskIndex;

    event LogNewTask   (uint256 indexed id, uint index, string name, string description);
    event LogUpdateTask(uint256 indexed id, uint index, string name, string description);
    event LogDeleteTask(uint256 indexed id, uint index);
    event TaskisDone(uint256 indexed id, bool done);

    function isTask(uint256 id)
        public view returns (bool isIndeed) {
        if(taskIndex.length == 0) return false;
        return (taskIndex[tasks[id].index] == id);
    }

    function insertTask(uint256 id, string memory name, string memory description)
         
        public returns(uint index) {
            if(isTask(id)) require(false); 
            tasks[id].id = id;
            tasks[id].name = name;
            tasks[id].description = description;
            tasks[id].index = taskIndex.push(id)-1;
            LogNewTask(
                id, 
                tasks[id].index, 
                name, 
                description);
            return taskIndex.length-1;
        }

    function deleteTask(uint256 id) 
        public returns(uint index) {
            if(!isTask(id)) require(false); 
            uint rowToDelete = tasks[id].index;
            uint keyToMove = taskIndex[taskIndex.length-1];
            taskIndex[rowToDelete] = keyToMove;
            tasks[keyToMove].index = rowToDelete; 
            taskIndex.length-1;
            LogDeleteTask(
                id, 
                rowToDelete);
            LogUpdateTask(
                keyToMove, 
                rowToDelete, 
                tasks[keyToMove].name, 
                tasks[keyToMove].description);
            return rowToDelete;
        }
    
    function getUser(uint256 id)
        public view returns(string memory name, string memory description, uint index) {
            if(!isTask(id)) require(false); 
            return(
            tasks[id].name, 
            tasks[id].description, 
            tasks[id].index);
        } 
    
    function updateTask(uint256 id, string memory name, string memory description) 
        public returns(bool success) {
            if(!isTask(id)) require(false); 
            tasks[id].name = name;
            tasks[id].description = description;
            LogUpdateTask(
            id, 
            tasks[id].index,
            name, 
            tasks[id].description);
            return true;
        }
    

    function getTaskCount() 
        public view returns(uint count) {
            return taskIndex.length;
        }

    function getTaskAtIndex(uint index)
        public view returns(uint256 id) {
            return taskIndex[index];
        }

    }