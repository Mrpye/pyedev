import React, { Component } from 'react';
import { withStyles } from '@material-ui/core/styles';
import { AudioPlayerStyle } from './AudioPlayerStyle';
import PropTypes from 'prop-types';


class AudioPlayer extends Component {
    constructor(props) {
        super(props)
        this.state = {
        };
        this.setAudioElementRef = this.setAudioElementRef.bind(this);
        this.audio = null;
    }

    componentDidMount() {
        const audio = this.audio;
        audio.volume=0.5;
        audio.crossOrigin = this.props.crossOrigin;
    }

    createAudioSourceCreated(e) {
        if (!this.props.createAudioSourceCreated) {
            return;
        }
        this.props.createAudioSourceCreated(e, this.state.audioSrc, this.state.context);
    };


    setAudioElementRef(ref) {
        this.audio = ref;
        if (typeof this.props.audioElementRef === 'function') {
            this.props.audioElementRef(this.audio);
        }
    }

    render() {       
        return (
            <audio
                ref={this.setAudioElementRef}
                autoPlay={true}
                controls={true}
                crossOrigin={"anonymous"}
                src={this.props.music_src}
            >
            </audio>

        );
    }
}
AudioPlayer.propTypes = {
    crossOrigin: PropTypes.oneOf([
        'anonymous',
        'use-credentials'
    ])
}

export default withStyles(AudioPlayerStyle)(AudioPlayer);