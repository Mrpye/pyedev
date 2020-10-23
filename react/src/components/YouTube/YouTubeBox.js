import React, { Component } from 'react';
import { withStyles } from '@material-ui/core/styles';
import { YouTubeBoxStyle } from './YouTubeBoxStyle';
import GridContainer from "../Grid/GridContainer.js";
import GridItem from "../Grid/GridItem.js";
import Modal from '@material-ui/core/Modal';
import classNames from "classnames";
import ReactPlayer from "react-player"

class YouTubeBox extends Component {
    constructor(props) {
        super(props)
        this.state = {
            audio_src: null,
            open: false
        };

        this.onClose = this.onClose.bind(this);
    }
    componentDidMount() { }
    onClose() {
        if (typeof this.props.onClose === 'function') {
            this.props.onClose();
        }
    }
    GetWidth() {
        const container_width = document.getElementById("container").clientWidth;
        const ratio = container_width / this.props.width;   // get ratio for scaling image
        return container_width
        //return (document.documentElement.clientWidth * 0.8);
    }
    GetHeight() {
        const container_width = document.getElementById("container").clientWidth;
        const ratio = container_width / this.props.width;   // get ratio for scaling image
        return this.props.height * ratio
        //return (document.documentElement.clientWidth * 0.8);
    }
    render() {
        const { classes } = this.props;
        const imageClasses = classNames(

            classes.imgFit
        );

        return (
            <Modal className={classes.modal}
                open={this.props.open}
                onClose={this.onClose}
                aria-labelledby="simple-modal-title"
                aria-describedby="simple-modal-description"
            >
                <div className={classes.paper}>
                    <GridContainer>
                        <GridItem xs={12} sm={12} md={12}>
                            <h2 id="simple-modal-title">{this.props.title}</h2>
                            <p id="simple-modal-description">{this.props.desc}</p>
                            <div className={classes.wrapper}>
                                <ReactPlayer
                                    className={classes.player}
                                    url={"https://www.youtube.com/embed/"+this.props.video_id}
                                    controls
                                    playbackRate={1}
                                    width='100%'
                                    height='100%'
                                />
                            </div>
                        </GridItem>
                    </GridContainer>
                </div>
            </Modal>
        )
    }
}
YouTubeBoxStyle.defaultProps = {
    cover_art: "/img/sonicbubble.png",
    music_src: null,
    title: "",
    desc: "",
    sound_cloud: true

};

export default withStyles(YouTubeBoxStyle)(YouTubeBox);