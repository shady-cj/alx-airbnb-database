 ## Retrieves messages sent by a user.
```
SET profiling = 1;
SELECT * FROM messages JOIN users
ON messages.sender_id = users.user_id;
SHOW PROFILES;
```

<img width="266" height="29" alt="showprofile -1" src="https://github.com/user-attachments/assets/c609bead-7b36-4687-af54-ef68cdc7f637" />



## Create an index on the sender_id on messages table to improve look ups;

```
CREATE INDEX messages_sender_idx ON messages(sender_id);
```


## Profile result after indexing the column.

<img width="312" height="27" alt="showprofile - 2" src="https://github.com/user-attachments/assets/52e6803c-2ac9-45a0-bd2c-37fc980a4d0a" />
