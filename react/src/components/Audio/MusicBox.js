import React, { Component } from 'react';
import { withStyles } from '@material-ui/core/styles';
import { MusicBoxStyle } from './MusicBoxStyle';
import GridContainer from "../Grid/GridContainer.js";
import GridItem from "../Grid/GridItem.js";
import Modal from '@material-ui/core/Modal';
import AudioPlayer from "components/Audio/AudioPlayer.js";
import Visual from "components/Audio/Visual.js";
import classNames from "classnames";

class MusicBox extends Component {
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
                        <GridItem xs={6} sm={6} md={6}>
                            <h2 id="simple-modal-title">{this.props.title}</h2>
                            <p id="simple-modal-description">{this.props.desc}</p>
                            <Visual audio_src={this.state.audio_src} ></Visual>
                            <AudioPlayer
                                audioElementRef={audio => {
                                    if (audio instanceof HTMLMediaElement) {
                                        const ctx = new AudioContext();
                                        let source = ctx.createMediaElementSource(audio);
                                        source.connect(ctx.destination);
                                        this.setState({ audio_src: source })
                                    }
                                }}
                                crossOrigin="anonymous"
                                music_src={this.props.music_src}
                            ></AudioPlayer>
                        </GridItem>
                        <GridItem xs={6} sm={6} md={6}>
                            <img src={this.props.cover_art} alt="..." className={classes.imgcover} />
                        </GridItem>
                    </GridContainer>
                </div>
            </Modal>

        );
    }
}
MusicBoxStyle.defaultProps = {
    cover_art: "/img/sonicbubble.png",
    music_src: null,
    title: "",
    desc: "",

};

export default withStyles(MusicBoxStyle)(MusicBox);