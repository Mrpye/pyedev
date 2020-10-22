import React, { Component } from 'react';
import { withStyles } from '@material-ui/core/styles';
import GridList from '@material-ui/core/GridList';
import GridListTile from '@material-ui/core/GridListTile';
import { AudioListStyle } from './AudioListStyle';
import AudioListItem from './AudioListItem';
import MusicBox from "./MusicBox.js";
import DirectusSDK from "@directus/sdk-js";
import CircularProgress from '@material-ui/core/CircularProgress';

class AudioList extends Component {
    constructor(props) {
        super(props)
        this.state = {
            open: false,
            music_list: null,
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

        client.getItems("music",
            {
                fields: ['*', 'image.data.*', 'music.data.*']
            }
        )
            .then(data => {
                // Do something with the data
                console.log(data);
                this.setState({ music_list: data.data })
            })
            .catch(error => console.error(error));

    }
    handleOpen = (e, data) => {
        if(data.sound_cloud==true){
            console.log("Soundcloud", data.sound_cloud_src)
            this.setState({
                open: true,
                title: data.title,
                desc: data.desc,
                img: data.image.data.full_url,
                audio: data.sound_cloud_src,
                sound_cloud:data.sound_cloud
            });
        }else{
            this.setState({
                open: true,
                title: data.title,
                desc: data.desc,
                img: data.image.data.full_url,
                audio: this.state.host + data.music.data.asset_url,
                sound_cloud:data.sound_cloud
            });
        }
        
    };

    handleClose = (e, data) => {
        this.setState({
            open: false
        });
    };

    render() {
        const { classes } = this.props;


        if (this.state.music_list == null) {
            return (
                <div className={classes.root}>
                    <CircularProgress />
                </div>
            );
        } else {



            return (
                <div className={classes.root}>
                    <MusicBox
                        open={this.state.open}
                        onClose={this.handleClose}
                        music_src={this.state.audio}
                        cover_art={this.state.img}
                        title={this.state.title}
                        desc={this.state.desc}
                        sound_cloud={this.state.sound_cloud}
                    ></MusicBox>
                    {this.state.music_list.map((data, index) => (
                        <AudioListItem key={index} data={data} onClicked={(e, data) => this.handleOpen(e, data)} ></AudioListItem>
                    ))}
                </div>
            );
        }


    }
}


export default withStyles(AudioListStyle)(AudioList);