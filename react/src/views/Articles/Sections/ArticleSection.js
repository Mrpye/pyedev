import React, { useState } from "react";
import ArticleList from "components/Articles/ArticleList.js";
import styles from "assets/jss/material-kit-react/views/landingPageSections/musicStyle.js";
const useStyles = styles;

export default function ArticleSection(props) {
  const classes = useStyles();

  function handleClicked(e, data) {
    
    if (typeof props.onBannerChange === 'function') {
      props.onBannerChange(data);
    }
  };
  return (
    <div className={classes.section}>

      <div>
        <ArticleList onOpened={handleClicked} ></ArticleList>
      </div>
    </div>
  );
}
