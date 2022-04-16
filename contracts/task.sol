// SPDX-License-Identifier: MIT
pragma solidity ^0.4.6;

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

    event LogNewUser   (uint256 indexed id, uint index, string name, string description);
    event LogUpdateUser(uint256 indexed id, uint index, string name, string description);
    event LogDeleteUser(uint256 indexed id, uint index);
    event TaskisDone(uint256 indexed id, bool done);

    function isTask(uint256 id)
        public view returns (bool isIndeed) {
        if(taskIndex.length == 0) return false;
        return (taskIndex[tasks[id].index] == id);
    }

    function insertTask(uint256 id, string name, string description)
         
        public returns(uint index) {
            if(isTask(id)) require(false); 
            tasks[id].id = id;
            tasks[id].name = name;
            tasks[id].description = description;
            tasks[id].index = taskIndex.push(id)-1;
            LogNewUser(
                id, 
                tasks[id].index, 
                name, 
                description);
            return taskIndex.length-1;
        }

    function deleteUser(uint256 id) 
        public returns(uint index) {
            if(!isTask(id)) require(false); 
            uint rowToDelete = tasks[id].index;
            uint keyToMove = taskIndex[taskIndex.length-1];
            taskIndex[rowToDelete] = keyToMove;
            tasks[keyToMove].index = rowToDelete; 
            taskIndex.length--;
            LogDeleteUser(
                id, 

                rowToDelete);
            LogUpdateUser(
                keyToMove, 
                rowToDelete, 
                tasks[keyToMove].name, 
                tasks[keyToMove].description);
            return rowToDelete;
        }
    
    function getUser(uint256 id)
        public view returns(string name, string description, uint index) {
            if(!isTask(id)) require(false); 
            return(
            tasks[id].name, 
            tasks[id].description, 
            tasks[id].index);
        } 
    
    function updateTask(uint256 id, string name, string description) 
        public returns(bool success) {
            if(!isTask(id)) require(false); 
            tasks[id].name = name;
            tasks[id].description = description;
            LogUpdateUser(
            id, 
            tasks[id].index,
            name, 
            tasks[id].description);
            return true;
        }
    

    function getUserCount() 
        public view returns(uint count) {
            return taskIndex.length;
        }

    function getUserAtIndex(uint index)
        public view returns(uint256 id) {
            return taskIndex[index];
        }

    }