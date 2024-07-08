<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Welcome to PrivNetF</title>
  <style>
    body {
      font-family: Arial, sans-serif;
      margin: 0;
      padding: 0;
      background-image: url('https://images.alphacoders.com/480/480282.jpg');
      background-size: cover;
      background-position: center;
    }

    .container {
      display: flex;
      max-width: 1200px;
      margin: 0 auto;
      padding: 20px;
    }

    .main-content {
      flex: 3;
      padding: 20px;
      background-color: rgb(102,68,0);
      border-radius: 5px;
      box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
    }

    .sidebar {
      flex: 1;
      background-color: rgb(153,102,0);
      padding: 20px;
      border-radius: 5px;
      box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
    }

    h1 {
      color: #E6BF00;
      margin-top: 0;
    }

    p {
      font-size: 16px;
      color: #E6BF00;
      line-height: 1.5;
      margin: 10px 0;
    }

    .player-wrapper {
      position: relative;
      padding-top: 56.25%; /* Player ratio: 16:9 */
      margin-bottom: 20px;
    }

    .player-wrapper-mini {
      position: relative;
      padding-top: 31.25%; /* Player ratio: 16:9 */
      margin-bottom: 20px;
    }

    .player {
      position: absolute;
      top: 0;
      left: 0;
      width: 100%;
      height: 100%;
    }

    .amazon-button {
      display: block;
      background-color: #ff9900;
      color: #fff;
      border: none;
      padding: 10px 20px;
      font-size: 16px;
      border-radius: 5px;
      cursor: pointer;
      transition: background-color 0.3s ease;
      text-align: center;
      text-decoration: none;
      margin-top: 20px;
    }

    .amazon-button:hover {
      background-color: #e68a00;
    }

    .sidebar-links {
      list-style: none;
      padding: 0;
    }

    .sidebar-links li {
      margin-bottom: 10px;
    }

    .sidebar-links a {
      color: #E6BF00;
      text-decoration: none;
      font-size: 14px;
      transition: color 0.3s ease;
    }

    .sidebar-links a:hover {
      color: #d08860;
    }
  </style>
</head>
<body>
  <div class="container">
    <div class="main-content">
      <h1>Welcome to PrivNetF</h1>
      <p>Thank you for visiting my site! Here, you can find a variety of content related to my interests and hobbies. Check out the video below to learn about the battle of powers:</p>
      <div class="player-wrapper">
        <iframe class="player" src="https://www.youtube.com/embed/aHUsgExbICM" frameborder="0" allowfullscreen></iframe>
      </div>
      <p>Below you can see the most recent example of my animation work:</p>
      <div class="player-wrapper-mini">
        <iframe class="player" src="https://www.youtube.com/embed/GDuJxls4vZA" frameborder="0" allowfullscreen></iframe>
      </div>
      <p>Also, take a look at my Amazon wish list, if you want to fuel my Tolkien addiction:</p>
      <a class="amazon-button" href="https://www.amazon.de/hz/wishlist/ls/3F5R1YFVLYFLS?ref_=wl_share" target="_blank">Amazon List</a>
    </div>
    <div class="sidebar">
      <h1>Additional Links</h1>
      <ul class="sidebar-links">
        <li><a href="https://github.com/j-baillie" target="blank">Github - j-baillie</a></li>
        <li><a href="https://steamcommunity.com/id/roy5ra/" target="blank">Steam - Turambar</a></li>
        <li><a href="https://youtu.be/dQw4w9WgXcQ" > Email contact </a></li>
        <li><a href="mailto:bozo@yahoo.com">actual Email contact</a></li>
      </ul>
    </div>
  </div>
</body>
</html>
