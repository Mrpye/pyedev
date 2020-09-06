import React, { useState } from "react";
// nodejs library that concatenates classes
import classNames from "classnames";
// @material-ui/core components


// @material-ui/icons

// core components
import GridContainer from "components/Grid/GridContainer.js";
import GridItem from "components/Grid/GridItem.js";
import Button from "components/CustomButtons/Button.js";
import Card from "components/Card/Card.js";
import CardBody from "components/Card/CardBody.js";
import CardFooter from "components/Card/CardFooter.js";

import AudioList from "components/Audio/AudioList.js";
import styles from "assets/jss/material-kit-react/views/landingPageSections/musicStyle.js";


const useStyles = styles;


export default function TeamSection() {
  const classes = useStyles();
  const [audio, setAudio] = useState(null);
  const [open, setOpen] = React.useState(false);

  const imageClasses = classNames(
    classes.imgRaised,
    classes.imgCard,
    classes.imgFluid
  );

  const imageClasses2 = classNames(
    classes.imgCard,
    classes.imgFluid
  );

 


  var Tracks =
    [{
      audio_src: process.env.PUBLIC_URL + "/music/LANDR-TrueWavev2-Medium-Balanced.mp3",
      cover_art: process.env.PUBLIC_URL + "/img/sonicbubble.png",
      title: 'Track 1 by Some Artist',
      description: 'This is a Description'
    }
    ];

  return (
    <div className={classes.section}>

      <h2 className={classes.title}>StretchMasterP Tracks</h2>
      <div>

       
        <AudioList></AudioList>
        

      </div>
    </div>
  );
}
