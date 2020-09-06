import React, { Component } from 'react';
import { withStyles } from '@material-ui/core/styles';
import GridList from '@material-ui/core/GridList';
import GridListTile from '@material-ui/core/GridListTile';
import { AudioListStyle } from './AudioListStyle';
import AudioListItem from './AudioListItem';
import MusicBox from "./MusicBox.js";
import DirectusSDK from "@directus/sdk-js";


class AudioList extends Component {
    constructor(props) {
        super(props)
        this.state = {
            open: false,
            music_list: null,
            host:"http://localhost"
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
            fields: ['*','image.data.*','music.data.*']
          }
        )
            .then(data => {
                // Do something with the data
                console.log(data);
                this.setState({music_list:data.data})
            })
            .catch(error => console.error(error));

    }
    handleOpen = (e, data) => {
        this.setState({
            open: true,
            title: data.title,
            desc: data.desc,
            img: data.image.data.full_url,
            audio: this.state.host+data.music.data.asset_url
        });
    };

    handleClose = (e, data) => {
        this.setState({
            open: false
        });
    };

    render() {
        const { classes } = this.props;
        if(this.state.music_list==null){
            return (<div>Loading</div>);
        }else{
            return (
                <div className={classes.root}>
                    <MusicBox
                        open={this.state.open}
                        onClose={this.handleClose}
                        music_src={this.state.audio}
                        cover_art={this.state.img}
                        title={this.state.title}
                        desc={this.state.desc}
                    ></MusicBox>
                    {this.state.music_list.map((data,index) => (
                        <AudioListItem key={index} data={data} onClicked={(e, data) => this.handleOpen(e, data)} ></AudioListItem>
                    ))}
                </div>
            );
        }
       
    }
}


export default withStyles(AudioListStyle)(AudioList);