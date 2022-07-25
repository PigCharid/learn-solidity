// SPDX-License-Identifier:MIT
pragma solidity ^0.8;

contract TodoList{
    struct Todo{
        string text;
        bool completed;
    }
    Todo[] public todos;
    function create(string calldata _text)external {
        todos.push(Todo({
            text : _text,
            completed : false
        }));


    }
    function updateText(uint _index,string calldata _text)external{
        todos[_index].text = _text;//应该要对text先做个检查
        //上面是直接更新法

        // 一个用一个storage变量来接住之前的结构体对象，然后进行修改  
        // 那么gas的消耗是看你更新的字段多不多，如果更新很多的字段，那么下面的gas可能会更加节省  4个字段的更新好像是临界值
        // Todo storage todo = todos[_index];
        // todo.text = _text;
    }
    function get(uint _index)external view returns(string memory,bool){
        Todo memory todo = todos[_index];
        return(todo.text,todo.completed);

        // 两种写法都是可以的   好像是装入到storage中更加节省gas

        // Todo storage todo1 = todos[_index];
        // return(todo1.text,todo1.compeleted);
    }
    function toggleCompleted(uint _index)external {
       todos[_index].completed =!todos[_index].completed;
    }
}