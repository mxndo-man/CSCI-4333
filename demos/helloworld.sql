CREATE TABLE users (
  user_id INT PRIMARY KEY,
  username VARCHAR(50) NOT NULL
);

CREATE TABLE profiles(
  profile_id INT PRIMARY KEY,
  user_id INT UNIQUE,
  bio TEXT,
  FOREIGN KEY(user_id) REFERENCES users(user_id)
);


INSERT INFO users VALUES(1,'alice');
INSERT INFO users VALUES(2,'bob');


INSERT INFO profiles VALUES(101,1,'Hello, I am Alice!');
INSERT INFO profiles VALUES(102,2,'Hello, I am Bob!');
