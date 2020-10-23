import React, { Component } from 'react';
import { withStyles } from '@material-ui/core/styles';
import { YouTubeListStyle } from './YouTubeListStyle';
import YouTubeListItem from './YouTubeListItem';
import YouTubeBox from "./YouTubeBox.js";
import DirectusSDK from "@directus/sdk-js";
import CircularProgress from '@material-ui/core/CircularProgress';

class YouTubeList extends Component {
    constructor(props) {
        super(props)
        this.state = {
            open: false,
            youtube_list: null,
            host: "http://api.pyedev.co.uk"
        };
        this.handleOpen = this.handleOpen.bind(this);
        this.handleClose = this.handleClose.bind(this);
    }

    componentDidMount() {

        const client = new DirectusSDK({
            url: this.state.host,
            project: "pyedev",
            storage: window.localStorage
        });

        client.getItems("youtube")
            .then(data => {
                // Do something with the data
                console.log(data);
                this.setState({ youtube_list: data.data })
            })
            .catch(error => console.error(error));

    }

    handleOpen = (e, data) => {
        this.setState({
            open: true,
            title: data.title,
            desc: data.description,
            short_desc: data.short_description,
            video_id: data.video_id
        });
    };

    handleClose = (e, data) => {
        this.setState({
            open: false
        });
    };

    render() {
        const { classes } = this.props;


        if (this.state.youtube_list == null) {
            return (
                <div className={classes.root}>
                    <CircularProgress />
                </div>
            );
        } else {
            return (
                <div className={classes.root}>
                    <YouTubeBox
                        open={this.state.open}
                        onClose={this.handleClose}
                        title={this.state.title}
                        desc={this.state.desc}
                        video_id={this.state.video_id}
                    ></YouTubeBox>
                    {this.state.youtube_list.map((data, index) => (
                        <YouTubeListItem key={index} data={data} onClicked={(e, data) => this.handleOpen(e, data)} ></YouTubeListItem>
                    ))}
                </div>
            );
        }


    }
}


export default withStyles(YouTubeListStyle)(YouTubeList);