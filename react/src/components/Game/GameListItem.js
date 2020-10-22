import React, { Component } from 'react';
import { withStyles } from '@material-ui/core/styles';
import { GameListItemStyle } from './GameListItemStyle';
import Card from '@material-ui/core/Card';
import CardHeader from '@material-ui/core/CardHeader';

class GameListItem extends Component {
  constructor(props) {
    super(props)
  }

  render() {
    const { classes } = this.props;
    return (
      <Card className={classes.root}>
        <CardHeader title={this.props.data.title} subheader={this.props.data.description} />
        <iframe src={this.props.data.src} height={this.props.data.height} width={this.props.data.width} frameborder="0"><a href={this.props.data.href}>{this.props.data.title}</a></iframe>
      </Card> 
    );
  }
}


export default withStyles(GameListItemStyle)(GameListItem);