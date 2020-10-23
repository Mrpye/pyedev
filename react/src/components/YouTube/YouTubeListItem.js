import React, { Component } from 'react';
import { withStyles } from '@material-ui/core/styles';
import Card from '@material-ui/core/Card';
import CardHeader from '@material-ui/core/CardHeader';
import CardMedia from '@material-ui/core/CardMedia';
import IconButton from '@material-ui/core/IconButton';
import PlayArrowIcon from '@material-ui/icons/PlayArrow';
import { YouTubeListItemStyle } from './YouTubeListItemStyle';

class YouTubeListItem extends Component {
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
        <CardHeader title={this.props.data.title} subheader={this.props.data.short_description} />
        <CardMedia className={classes.cover} image={"http://i3.ytimg.com/vi/"+this.props.data.video_id+"/maxresdefault.jpg"} title={this.props.data.title} />
        <IconButton aria-label="play/pause" onClick ={(e) => this.handleClicked(e,this.props.data)}>
          <PlayArrowIcon className={classes.playIcon}  />
        </IconButton>
      </Card>
    );
  }
}

YouTubeListItem.defaultProps = {
  data: {
    img: "/img/sonicbubble.png",
    desc: "Hard hitting track",
    title: "Sonic Bubble",
    desc: "Hard hitting track",
    audio:"/music/LANDR-TrueWavev2-Medium-Balanced.mp3"
  }
}

export default withStyles(YouTubeListItemStyle)(YouTubeListItem);