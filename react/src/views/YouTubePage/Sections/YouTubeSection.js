import React, { useState } from "react";
import YouTubeList from "components/YouTube/YouTubeList.js";
import styles from "assets/jss/material-kit-react/views/landingPageSections/musicStyle.js";
const useStyles = styles;

export default function YouTubeSection() {
  const classes = useStyles();
  return (
    <div className={classes.section}>
      <h2 className={classes.title}>StretchMasterP YouTube Videos</h2>
      <div>
        <YouTubeList></YouTubeList>
      </div>
    </div>
  );
}
