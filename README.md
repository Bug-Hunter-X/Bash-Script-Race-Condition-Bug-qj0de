# Bash Script Race Condition

This repository demonstrates a race condition bug in a bash script.  The script uses two processes to concurrently increment a counter stored in a file. Due to the race condition, the final counter value is often less than the expected value of 2000.

The `bug.sh` file contains the buggy script, and the `bugSolution.sh` file provides a solution using file locking to prevent the race condition.

## Running the code

1. Clone the repository.
2. Navigate to the repository directory.
3. Run the buggy script using `bash bug.sh`.
4. Observe that the final counter value is likely less than 2000.
5. Run the solution script using `bash bugSolution.sh`.
6. Observe that the final counter value is now 2000.

## Bug and Solution

The bug is caused by the concurrent access to the counter file. Both processes read the value, increment it, and then write it back. If both processes read the same value simultaneously, only one of the increments will be reflected in the final value.

The solution uses `flock` to acquire a lock on the counter file before accessing it.  This ensures that only one process can access the file at a time, preventing the race condition.