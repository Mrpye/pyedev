import React, { useState } from "react";
import AudioList from "components/Audio/AudioList.js";
import styles from "assets/jss/material-kit-react/views/landingPageSections/musicStyle.js";
const useStyles = styles;

export default function TeamSection() {
  const classes = useStyles();
  return (
    <div className={classes.section}>
      <h2 className={classes.title}>StretchMasterP Tracks</h2>
      <div>
        <AudioList></AudioList>
      </div>
    </div>
  );
}
