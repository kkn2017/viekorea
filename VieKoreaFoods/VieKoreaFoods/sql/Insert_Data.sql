use VieKoreaRestaurant
go

/** Inset Products **/
INSERT INTO Products 
([name],briefDescription,fullDescription,statusCode, statusId, price,featured,categoryId,imageId)
VALUES (N'Kimbap', N'Gimbap is a Korean dish made from cooked rice.', N'Gimbap is a Korean dish made from cooked rice and other ingredients that are rolled in gim and served in bite sized slices.', 1, 1, 5.0000, 1, 2, 1),
(N'SulrungTang', N'SulrungTang is made from ox bones.', N'Seolleongtang is a Korean broth soup made from ox bones, brisket and other cuts. Seasoning is generally done at the table according to personal taste by adding salt, ground black pepper, red pepper, minced garlic, or chopped spring onions. It is a local dish of Seoul.', 1, 1, 10.0000, 1, 2, 2),
(N'Makguksu', N'Makguksu is a Korean buckwheat noodle dish.', N'Makguksu or buckwheat noodles is a Korean buckwheat noodle dish served in a chilled broth and sometimes with sugar, mustard, sesame oil or vinegar. It is a local specialty of the Gangwon province of South Korea, and its capital city, Chuncheon.', 1, 1, 8.0000, 1, 2, 3),
(N'Kalbijjim', N'Kalbijjim is a variety of jjim or Korean steamed dish made with Kalbi.', N'Kalbijjim or braised short ribs is a variety of jjim or Korean steamed dish made with galbi. Beef galbi is sometimes referred to as gari, so the dish can be called garijjim. Galbijjim is generally made with beef or pork short ribs. In the latter case, it is called dweji galbijjim.', 1, 1, 20.0000, 1, 2, 4),
(N'Pho', N'Pho is a Vietnamese soup consisting of broth, rice noodles, herbs, and meat.', N'Pho is a Vietnamese soup consisting of broth, rice noodles, herbs, and meat. Pho originated in the early 20th century in northern Vietnam, and was popularized throughout the world by refugees after the Vietnam War. Because phos origins are poorly documented,[7][8] there is disagreement over the cultural influences that led to its development in Vietnam, as well as the etymology of the name.[9] The Hanoi (northern) and Saigon (southern) styles of pho differ by noodle width, sweetness of broth, and choice of herbs.', 1, 1, 10.0000, 2, 1, 5)

INSERT INTO ProductStatus(status)
VALUES ('Available'),
('Out of stock'),
('Back ordered'),
('Temporarily available'),
('Discontinued')

/** Inset Categories **/
INSERT INTO Categories(name, description)
VALUES ('Vietnamese Cuisine', 'With each drink you try in Vietnam, you experience the influence of one hundred years of French and a thousand years of Chinese rule.'),
('Korean Cuisine', 'Korean cuisine includes many types of noodles. These are often served in soup but are also served directly.')


/** Inset SiteImages **/
INSERT SiteImages (name, uploadDate, altText) 
VALUES (N'~/img/foods/kimbab.png', CAST(N'2019-03-05T00:00:00.000' AS DateTime), N'Kimbap'),
(N'~/img/foods/seolleongtang.png', CAST(N'2019-03-05T00:00:00.000' AS DateTime), N'SulrungTang'),
(N'~/img/foods/makguksu.png', CAST(N'2019-03-05T00:00:00.000' AS DateTime), N'Makguksu'),
(N'~/img/foods/galbijjim.png', CAST(N'2019-03-05T00:00:00.000' AS DateTime), N'Kalbijjim'),
(N'~/img/foods/pho.png', CAST(N'2019-03-05T00:00:00.000' AS DateTime), N'Pho')


/** Insert Admin **/

SET IDENTITY_INSERT [dbo].[adminLogin] ON 

INSERT [dbo].[adminLogin] ([id], [userName], [password]) VALUES (1, N'alex001', N'password-001')
SET IDENTITY_INSERT [dbo].[adminLogin] OFF