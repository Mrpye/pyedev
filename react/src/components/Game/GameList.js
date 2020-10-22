import React, { Component } from 'react';
import { withStyles } from '@material-ui/core/styles';
import GridList from '@material-ui/core/GridList';
import GridListTile from '@material-ui/core/GridListTile';
import { GameListStyle } from './GameListStyle';
import GameListItem from './GameListItem';
import DirectusSDK from "@directus/sdk-js";
import CircularProgress from '@material-ui/core/CircularProgress';
import ReactMarkdown from "react-markdown";


class GameList extends Component {
    constructor(props) {
        super(props)
        this.state = {
            open: false,
            article_list: null,
            host: "http://api.pyedev.co.uk"
        };
    }

    
    componentDidMount() {

        const client = new DirectusSDK({
            url: this.state.host,
            project: "pyedev",
            storage: window.localStorage
        });

        client.getItems("games")
            .then(data => {
                // Do something with the data
                console.log(data);
                this.setState({ article_list: data.data })
            })
            .catch(error => console.error(error));

    }
   

    render() {
        const { classes } = this.props;
        if (this.state.open) {
            return (
                <div>
                    <div>
                        <hr/>
                        <h2 className={classes.title}>StretchMasterP Games</h2>
                        <div className={classes.root}>
                            {this.state.article_list.map((data, index) => (
                                <GameListItem key={index} data={data}></GameListItem>
                            ))}
                        </div>
                    </div>
                </div>
            );
        } else {
            if (this.state.article_list == null) {
                return (
                    <div className={classes.root}>
                        <CircularProgress />
                    </div>
                );
            } else {
                return (
                    <div>
                        <h2 className={classes.title}>StretchMasterP Games</h2>
                        <div className={classes.root}>
                            {this.state.article_list.map((data, index) => (
                                <div>
                               <GameListItem key={index} data={data}></GameListItem>
                               <br/>
                               </div>
                            ))}
                        </div>
                    </div>
                );
            }
        }

    }
}


export default withStyles(GameListStyle)(GameList);