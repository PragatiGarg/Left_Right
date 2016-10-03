DROP TABLE vote;
DROP TABLE notifs;
DROP TABLE pool;
DROP TABLE user_groups;
DROP TABLE post;
DROP TABLE groups;
DROP TABLE image;
DROP TABLE category;
DROP TABLE user;


CREATE TABLE user (
    user_id INT(50) UNIQUE NOT NULL AUTO_INCREMENT,
    email_id VARCHAR(50) UNIQUE NOT NULL,
    name VARCHAR(50) NOT NULL,
    password VARCHAR(50) NOT NULL,
    recovery_phn BIGINT UNIQUE NOT NULL,
    level TINYINT NOT NULL DEFAULT 0,
    points INT(50) NOT NULL DEFAULT 0,
    PRIMARY KEY (user_id)
);

CREATE TABLE category (
    category_id INT(50) UNIQUE NOT NULL AUTO_INCREMENT,
    category_name VARCHAR(50) UNIQUE NOT NULL,
    PRIMARY KEY (category_id)
);

CREATE TABLE image (
    image_id INT(50) UNIQUE NOT NULL AUTO_INCREMENT,
    image_path VARCHAR(50) UNIQUE NOT NULL,
    user_id INT(50) NOT NULL,
    category_id INT(50) NOT NULL,
    PRIMARY KEY (image_id),
    FOREIGN KEY (user_id)
        REFERENCES user (user_id),
    FOREIGN KEY (category_id)
        REFERENCES category (category_id)
);

CREATE TABLE groups (
    group_id INT(50) NOT NULL UNIQUE AUTO_INCREMENT,
    group_name VARCHAR(50) NOT NULL UNIQUE,
    no_of_members INT(50) NOT NULL DEFAULT 1,
    PRIMARY KEY (group_id)
);

CREATE TABLE post (
    post_id INT(50) UNIQUE NOT NULL AUTO_INCREMENT,
    image_id_left int(50) unique not null,
    image_id_right int(50) unique not null,
    numleft INT(50) NOT NULL DEFAULT 0,
    numright INT(50) NOT NULL DEFAULT 0,
    post_time TIMESTAMP NOT NULL,
    group_id int(50),
    PRIMARY KEY (post_id),
    FOREIGN KEY (image_id_left)
        REFERENCES image (image_id),/*make it not uniue left right both*/
	FOREIGN KEY (image_id_right)
        REFERENCES image (image_id),
	FOREIGN KEY (group_id)
        REFERENCES groups (group_id)
);

CREATE TABLE user_groups (
    group_id INT(50) NOT NULL,
    user_id INT(50) NOT NULL,
    membership_type ENUM('NotReplied', 'Member', 'Admin', 'Creator'),
    FOREIGN KEY (group_id)
        REFERENCES groups (group_id),
    FOREIGN KEY (user_id)
        REFERENCES user (user_id)
);

CREATE TABLE pool (
    pool_image_id INT(50) NOT NULL UNIQUE AUTO_INCREMENT,
    image_id INT(50) NOT NULL UNIQUE,
    create_date TIMESTAMP NOT NULL,
    PRIMARY KEY (pool_image_id),
    FOREIGN KEY (image_id)
        REFERENCES image (image_id)
);

CREATE TABLE notifs (
    notif_id INT(50) NOT NULL UNIQUE AUTO_INCREMENT,
    user_id INT(50) NOT NULL,
    stat ENUM('Unread', 'Read'),
    post_id INT(50) NOT NULL,
    relate ENUM('Owner', 'Voter', 'Part'),
    notif_time TIMESTAMP NOT NULL,
    PRIMARY KEY (notif_id),
    FOREIGN KEY (user_id)
        REFERENCES user (user_id),
    FOREIGN KEY (post_id)
        REFERENCES post (post_id)
);

CREATE TABLE vote (
    vote_id INT(50) NOT NULL UNIQUE AUTO_INCREMENT,
    user_id INT(50) NOT NULL,
    post_id INT(50) NOT NULL,
    sidvotee ENUM('Left', 'Right') NOT NULL,
    PRIMARY KEY (vote_id),
    FOREIGN KEY (user_id)
        REFERENCES user (user_id),
    FOREIGN KEY (post_id)
        REFERENCES post (post_id),
    UNIQUE (user_id , post_id)
);

/* HashTags and Newsfeed */
/* Newsfeed like inshorts */
/* Newsfeed order by time desc */
/* Location of a post */
/* Locational difference between post and current user's location */
