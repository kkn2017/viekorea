use VieKoreaRestaurant
go

/**Inset ProductStatus **/
INSERT INTO ProductStatus(status)
VALUES ('Available'),
('Out of stock'),
('Back ordered'),
('Temporarily available'),
('Discontinued');

/** Inset Categories **/
INSERT INTO Categories(name, description)
VALUES ('Vietnamese Cuisine', 'With each drink you try in Vietnam, you experience the influence of one hundred years of French and a thousand years of Chinese rule.'),
('Korean Cuisine', 'Korean cuisine includes many types of noodles. These are often served in soup but are also served directly.');

/** Inset SiteImages **/
-- DELETE FROM SiteImages WHERE id >= 1;
-- DBCC CHECKIDENT ('dbo.SiteImages', RESEED, 0);
INSERT SiteImages (name, uploadDate, altText) 
VALUES (N'~/img/foods/kimbab.png', CAST(N'2019-03-05T00:00:00.000' AS DateTime), N'Kimbab'),
(N'~/img/foods/seolleongtang.png', CAST(N'2019-03-05T00:00:00.000' AS DateTime), N'SulrungTang'),
(N'~/img/foods/makguksu.png', CAST(N'2019-03-05T00:00:00.000' AS DateTime), N'Makguksu'),
(N'~/img/foods/galbijjim.png', CAST(N'2019-03-05T00:00:00.000' AS DateTime), N'Galbijjim'),
(N'~/img/foods/bibimbap.png', CAST(N'2019-03-05T00:00:00.000' AS DateTime), N'Bibimbap'),
(N'~/img/foods/mandu.jpg', CAST(N'2019-03-05T00:00:00.000' AS DateTime), N'Mandu'),
(N'~/img/foods/squid-stir-fry.jpg', CAST(N'2019-03-05T00:00:00.000' AS DateTime), N'Squid Fry'),
(N'~/img/foods/tteokbokki.jpg', CAST(N'2019-03-05T00:00:00.000' AS DateTime), N'Tteokbokki'),
(N'~/img/foods/pho.png', CAST(N'2019-03-05T00:00:00.000' AS DateTime), N'Pho'),
(N'~/img/foods/chaca.png', CAST(N'2019-03-05T00:00:00.000' AS DateTime), N'ChaCa'),
(N'~/img/foods/fried-spring-rolls.jpg', CAST(N'2019-03-05T00:00:00.000' AS DateTime), N'Fried Spring Roll'),
(N'~/img/foods/fried-fish.jpg', CAST(N'2019-03-05T00:00:00.000' AS DateTime), N'Fried Fish'),
(N'~/img/foods/fried-rice.jpg', CAST(N'2019-03-05T00:00:00.000' AS DateTime), N'Fried Rice'),
(N'~/img/foods/bibim-noodle.jpg', CAST(N'2019-03-05T00:00:00.000' AS DateTime), N'Noodle'),
(N'~/img/foods/miso-soup.jpg', CAST(N'2019-03-05T00:00:00.000' AS DateTime), N'Miso Soup'),
(N'~/img/foods/fried-duck.jpg', CAST(N'2019-03-05T00:00:00.000' AS DateTime), N'Fried Duck');

/** Inset Products **/
-- DELETE FROM Products WHERE id >= 1000;
-- DBCC CHECKIDENT ('dbo.Products', RESEED, 1000);
INSERT INTO Products 
([name],briefDescription,fullDescription,statusCode, statusId, price,featured,categoryId,imageId)
VALUES (N'Kimbap', N'Gimbap is a Korean dish made from cooked rice.', N'Gimbap is a Korean dish made from cooked rice and other ingredients that are rolled in gim and served in bite sized slices.', 1, 1, 5.0000, 1, 2, 1),
(N'SulrungTang', N'SulrungTang is made from ox bones.', N'Seolleongtang is a Korean broth soup made from ox bones, brisket and other cuts. Seasoning is generally done at the table according to personal taste by adding salt, ground black pepper, red pepper, minced garlic, or chopped spring onions. It is a local dish of Seoul.', 1, 1, 10.0000, 1, 2, 2),
(N'Makguksu', N'Makguksu is a Korean buckwheat noodle dish.', N'Makguksu or buckwheat noodles is a Korean buckwheat noodle dish served in a chilled broth and sometimes with sugar, mustard, sesame oil or vinegar. It is a local specialty of the Gangwon province of South Korea, and its capital city, Chuncheon.', 1, 1, 8.0000, 1, 2, 3),
(N'Kalbijjim', N'Kalbijjim is a variety of jjim or Korean steamed dish made with Kalbi.', N'Kalbijjim or braised short ribs is a variety of jjim or Korean steamed dish made with galbi. Beef galbi is sometimes referred to as gari, so the dish can be called garijjim. Galbijjim is generally made with beef or pork short ribs. In the latter case, it is called dweji galbijjim.', 1, 1, 15.0000, 1, 2, 4),
(N'Bibimbap', N'Kalbijjim is a variety of jjim or Korean steamed dish made with Kalbi.', N'Kalbijjim or braised short ribs is a variety of jjim or Korean steamed dish made with galbi. Beef galbi is sometimes referred to as gari, so the dish can be called garijjim. Galbijjim is generally made with beef or pork short ribs. In the latter case, it is called dweji galbijjim.', 1, 1, 20.0000, 0, 2, 5),
(N'Mandu', N'Kalbijjim is a variety of jjim or Korean steamed dish made with Kalbi.', N'Kalbijjim or braised short ribs is a variety of jjim or Korean steamed dish made with galbi. Beef galbi is sometimes referred to as gari, so the dish can be called garijjim. Galbijjim is generally made with beef or pork short ribs. In the latter case, it is called dweji galbijjim.', 1, 1, 7.0000, 0, 2, 6),
(N'Squid Fry', N'Kalbijjim is a variety of jjim or Korean steamed dish made with Kalbi.', N'Kalbijjim or braised short ribs is a variety of jjim or Korean steamed dish made with galbi. Beef galbi is sometimes referred to as gari, so the dish can be called garijjim. Galbijjim is generally made with beef or pork short ribs. In the latter case, it is called dweji galbijjim.', 1, 1, 13.0000, 0, 2, 7),
(N'Tteokbokki', N'Kalbijjim is a variety of jjim or Korean steamed dish made with Kalbi.', N'Kalbijjim or braised short ribs is a variety of jjim or Korean steamed dish made with galbi. Beef galbi is sometimes referred to as gari, so the dish can be called garijjim. Galbijjim is generally made with beef or pork short ribs. In the latter case, it is called dweji galbijjim.', 1, 1, 15.0000, 0, 2, 8),
(N'Pho', N'Pho is a Vietnamese soup consisting of broth, rice noodles, herbs, and meat.', N'Pho is a Vietnamese soup consisting of broth, rice noodles, herbs, and meat. Pho originated in the early 20th century in northern Vietnam, and was popularized throughout the world by refugees after the Vietnam War. Because phos origins are poorly documented,[7][8] there is disagreement over the cultural influences that led to its development in Vietnam, as well as the etymology of the name.[9] The Hanoi (northern) and Saigon (southern) styles of pho differ by noodle width, sweetness of broth, and choice of herbs.', 1, 1, 10.0000, 0, 1, 9),
(N'ChaCa', N'Hanoians consider cha ca to be so exceptional that there is a street in the capital dedicated to these fried morsels of fish.', N'one of the oldest eateries in Hanoi, Vietnam, and the first to set up shop on Cha Ca Street, over a century ago. Along the busy road, where spiderwebs of exposed electric wires hang overhead, dozens of specialists compete to sell the best cha ca, crispy turmeric marinated fish thats fried tableside in a pan with herbs.', 1, 1, 18.0000, 0, 1, 10),
(N'Spring Roll', N'Hanoians consider cha ca to be so exceptional that there is a street in the capital dedicated to these fried morsels of fish.', N'one of the oldest eateries in Hanoi, Vietnam, and the first to set up shop on Cha Ca Street, over a century ago. Along the busy road, where spiderwebs of exposed electric wires hang overhead, dozens of specialists compete to sell the best cha ca, crispy turmeric marinated fish thats fried tableside in a pan with herbs.', 1, 1, 13.0000, 0, 1, 11),
(N'Fried Fish', N'Hanoians consider cha ca to be so exceptional that there is a street in the capital dedicated to these fried morsels of fish.', N'one of the oldest eateries in Hanoi, Vietnam, and the first to set up shop on Cha Ca Street, over a century ago. Along the busy road, where spiderwebs of exposed electric wires hang overhead, dozens of specialists compete to sell the best cha ca, crispy turmeric marinated fish thats fried tableside in a pan with herbs.', 1, 1, 8.0000, 0, 1, 12),
(N'Fried Rice', N'Hanoians consider cha ca to be so exceptional that there is a street in the capital dedicated to these fried morsels of fish.', N'one of the oldest eateries in Hanoi, Vietnam, and the first to set up shop on Cha Ca Street, over a century ago. Along the busy road, where spiderwebs of exposed electric wires hang overhead, dozens of specialists compete to sell the best cha ca, crispy turmeric marinated fish thats fried tableside in a pan with herbs.', 1, 1, 20.0000, 0, 1, 13),
(N'Noodle', N'Hanoians consider cha ca to be so exceptional that there is a street in the capital dedicated to these fried morsels of fish.', N'one of the oldest eateries in Hanoi, Vietnam, and the first to set up shop on Cha Ca Street, over a century ago. Along the busy road, where spiderwebs of exposed electric wires hang overhead, dozens of specialists compete to sell the best cha ca, crispy turmeric marinated fish thats fried tableside in a pan with herbs.', 1, 1, 15.0000, 0, 1, 14),
(N'Miso Soup', N'Hanoians consider cha ca to be so exceptional that there is a street in the capital dedicated to these fried morsels of fish.', N'one of the oldest eateries in Hanoi, Vietnam, and the first to set up shop on Cha Ca Street, over a century ago. Along the busy road, where spiderwebs of exposed electric wires hang overhead, dozens of specialists compete to sell the best cha ca, crispy turmeric marinated fish thats fried tableside in a pan with herbs.', 1, 1, 12.0000, 0, 1, 15),
(N'Fried Duck', N'Hanoians consider cha ca to be so exceptional that there is a street in the capital dedicated to these fried morsels of fish.', N'one of the oldest eateries in Hanoi, Vietnam, and the first to set up shop on Cha Ca Street, over a century ago. Along the busy road, where spiderwebs of exposed electric wires hang overhead, dozens of specialists compete to sell the best cha ca, crispy turmeric marinated fish thats fried tableside in a pan with herbs.', 1, 1, 10.0000, 0, 1, 16);

/** Insert Admin **/ 
INSERT INTO adminLogin (userName, password) VALUES (N'alex001', N'password-001');