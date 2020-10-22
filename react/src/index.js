import React from "react";
import ReactDOM from "react-dom";
import { createBrowserHistory } from "history";
import { Router, Route, Switch } from "react-router-dom";

import "assets/scss/material-kit-react.scss?v=1.9.0";

// pages for this product
import MusicPage from "views/MusicPage/MusicPage.js";
import ArticlePage from "views/Articles/ArticlePage.js";
import GamePage from "views/Games/GamePage.js";



// This returns a promise - don't try to access any data until this promise resolves


var hist = createBrowserHistory();

ReactDOM.render(
  <Router history={hist}>
    <Switch>
      <Route path="/music-page" component={MusicPage} />
      <Route path="/article-page" component={ArticlePage} />
      <Route path="/game-page" component={GamePage} />
      <Route path="/" component={ArticlePage} />
    </Switch>
  </Router>,
  document.getElementById("root")
);
