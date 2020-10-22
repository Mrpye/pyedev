import React, { useState } from "react";
import GameList from "components/Game/GameList.js";
import styles from "assets/jss/material-kit-react/views/landingPageSections/musicStyle.js";
const useStyles = styles;

export default function GameSection(props) {
  const classes = useStyles();

  function handleClicked(e, data) {
    
    if (typeof props.onBannerChange === 'function') {
      props.onBannerChange(data);
    }
  };
  return (
    <div className={classes.section}>

      <div>
        <GameList onOpened={handleClicked} ></GameList>
      </div>
    </div>
  );
}
