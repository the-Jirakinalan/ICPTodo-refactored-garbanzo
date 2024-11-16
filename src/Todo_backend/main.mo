import Array "mo:base/Array";
actor ToDoList {

    // Define a type for a Task
    type Task = {
        description: Text;
        completed: Bool;
    };

    // Mutable array to store tasks
    var tasks: [Task] = [];

    // Function to add a new task
    public func addTask(description: Text): async Text {
        let newTask: Task = {
            description = description;
            completed = false
        };

        // Add the new task to the array
        tasks := Array.append<Task>(tasks, [newTask]);
        return "Task added: " # description;
    };

    // Function to retrieve all tasks
    public func getTasks(): async [Task] {
        return tasks;
    };

    // Function to mark a task as completed by its index
    public func markTaskAsCompleted(index: Nat): async Text {
        if (index < tasks.size()) {
            // Create a new array with the updated task
            let updatedTask: Task = {
                description = tasks[index].description;
                completed = true
            };

            // Replace the task at the specified index
            tasks := Array.tabulate<Task>(
                tasks.size(),
                func(i: Nat): Task {
                    if (i == index) {
                        return updatedTask; // Use the updated task at the specified index
                    };
                    return tasks[i]; // Otherwise, keep the original task
                }
            );

            return "Task marked as completed: " # updatedTask.description;
        } else {
            return "Error: Invalid task index.";
        };
    };
}
