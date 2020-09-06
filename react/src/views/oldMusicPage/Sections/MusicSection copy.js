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
import MusicBox from "components/Audio/MusicBox.js";
import styles from "assets/jss/material-kit-react/views/landingPageSections/musicStyle.js";
import Track1 from "assets/img/music/sonicbubble.png";

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

  const handleOpen = () => {
    setOpen(true);
  };

  const handleClose = () => {
    setOpen(false);
  };


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

      <h2 className={classes.title}>Here is our team</h2>
      <div>

        <MusicBox
          open={open}
          onClose={handleClose}
          music_src={process.env.PUBLIC_URL + "/music/LANDR-TrueWavev2-Medium-Balanced.mp3"}
          cover_art={process.env.PUBLIC_URL + "/img/sonicbubble.png"}
        ></MusicBox>

        <GridContainer>
          <GridItem xs={12} sm={12} md={4}>
            <Card plain>
              <GridItem xs={12} sm={12} md={6} className={classes.itemGrid}>
                <img src={Track1} alt="..." className={imageClasses} />
              </GridItem>

              <h4 className={classes.cardTitle}>
                True Wave
                <br />
                <small className={classes.smallTitle}>Dance, Electronic</small>
              </h4>
              <CardBody>


                <button type="button" onClick={handleOpen}>
                  Open Modal
      </button>
              </CardBody>
              <CardFooter className={classes.justifyCenter}>
                <Button
                  justIcon
                  color="transparent"
                  className={classes.margin5}
                >
                  <i className={classes.socials + " fab fa-soundcloud"} />
                </Button>
              </CardFooter>
            </Card>
          </GridItem>

          <GridItem xs={12} sm={12} md={4}>
            <Card plain>
              <GridItem xs={12} sm={12} md={6} className={classes.itemGrid}>
                <img src={Track1} alt="..." className={imageClasses} />
              </GridItem>

              <h4 className={classes.cardTitle}>
                True Wave
                <br />
                <small className={classes.smallTitle}>Dance, Electronic</small>
              </h4>
              <CardBody>

              </CardBody>
              <CardFooter className={classes.justifyCenter}>
                <Button
                  justIcon
                  color="transparent"
                  className={classes.margin5}
                >
                  <i className={classes.socials + " fab fa-soundcloud"} />
                </Button>
              </CardFooter>
            </Card>
          </GridItem>
          <GridItem xs={12} sm={12} md={4}>
            <Card plain>
              <GridItem xs={12} sm={12} md={6} className={classes.itemGrid}>
                <img src={Track1} alt="..." className={imageClasses} />
              </GridItem>

              <h4 className={classes.cardTitle}>
                True Wave
                <br />
                <small className={classes.smallTitle}>Dance, Electronic</small>
              </h4>
              <CardBody>

              </CardBody>
              <CardFooter className={classes.justifyCenter}>
                <Button
                  justIcon
                  color="transparent"
                  className={classes.margin5}
                >
                  <i className={classes.socials + " fab fa-soundcloud"} />
                </Button>
              </CardFooter>
            </Card>
          </GridItem>

        </GridContainer>

      </div>
    </div>
  );
}
