
-- Table structure for table pizzas
--

CREATE TABLE pizzas (
  id int(11) PRIMARY KEY AUTO_INCREMENT,
  title varchar(255) NOT NULL,
  ingredients varchar(255) NOT NULL,
  email varchar(255) NOT NULL,
  created_at timestamp NOT NULL DEFAULT current_timestamp()
); 

--
-- Dumping data for table pizzas
--

INSERT INTO pizzas (id, title, ingredients, email, created_at) VALUES
(1, 'Pepperoni', 'mozzarella, pepperoni', 'user1@email.com', '2021-08-23 06:39:37'),
(2, 'Hawaiian', 'pineapple, cheese, ham', 'user3@email.com', '2021-08-27 02:13:19'),
(3, 'Mega Deluxe Supreme', 'cheese', 'user4@email.com', '2021-08-27 06:29:46');

