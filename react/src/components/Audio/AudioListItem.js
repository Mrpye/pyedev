import React, { Component } from 'react';
import { withStyles } from '@material-ui/core/styles';
import Card from '@material-ui/core/Card';
import CardHeader from '@material-ui/core/CardHeader';
import CardMedia from '@material-ui/core/CardMedia';
import IconButton from '@material-ui/core/IconButton';
import PlayArrowIcon from '@material-ui/icons/PlayArrow';
import { AudioListItemStyle } from './AudioListItemStyle';

class AudioListItem extends Component {
  constructor(props) {
    super(props)

    this.handleClicked = this.handleClicked.bind(this);
  }

  handleClicked = (e,data) => {
    if (typeof this.props.onClicked === 'function') {
      this.props.onClicked(e,data);
    }
  };
 
  render() {
    const { classes } = this.props;
    return (
      <Card className={classes.root}>
        <CardHeader title={this.props.data.title} subheader={this.props.data.description} />
        <CardMedia className={classes.cover} image={this.props.data.image.data.full_url} title={this.props.data.title} />
        <IconButton aria-label="play/pause" onClick ={(e) => this.handleClicked(e,this.props.data)}>
          <PlayArrowIcon className={classes.playIcon}  />
        </IconButton>
      </Card>
    );
  }
}

AudioListItem.defaultProps = {
  data: {
    img: "/img/sonicbubble.png",
    desc: "Hard hitting track",
    title: "Sonic Bubble",
    desc: "Hard hitting track",
    audio:"/music/LANDR-TrueWavev2-Medium-Balanced.mp3"
  }
}

export default withStyles(AudioListItemStyle)(AudioListItem);