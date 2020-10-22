import React, { Component } from 'react';
import { withStyles } from '@material-ui/core/styles';
import GridList from '@material-ui/core/GridList';
import GridListTile from '@material-ui/core/GridListTile';
import { ArticleListStyle } from './ArticleListStyle';
import ArticleListItem from './ArticleListItem';
import DirectusSDK from "@directus/sdk-js";
import CircularProgress from '@material-ui/core/CircularProgress';
import ReactMarkdown from "react-markdown";
import CodeBlock from "./CodeBlock";

class ArticleList extends Component {
    constructor(props) {
        super(props)
        this.state = {
            open: false,
            article_list: null,
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

        client.getItems("articles",
            {
                fields: ['*', 'image.data.*']
            }
        )
            .then(data => {
                // Do something with the data
                console.log(data);
                this.setState({ article_list: data.data })
            })
            .catch(error => console.error(error));

    }
    handleOpen = (e, data) => {
        this.setState({
            open: true,
            title: data.title,
            desc: data.description,
            img: data.image.data.full_url,
            content: data.content
        });
        //pass back the data of the item opened
        if (typeof this.props.onOpened === 'function') {
            this.props.onOpened(e,data);
        }
    };

    handleClose = (e, data) => {
        this.setState({
            open: false
        });
    };

    render() {
        const { classes } = this.props;
        if (this.state.open) {
            return (
                <div>
                     
                    <div className={classes.markdown}>
                   
                        <ReactMarkdown
                            source={this.state.content}
                            escapeHtml={false}
                            renderers={{ code: CodeBlock }}
                        />
                    </div>
                    <div>
                        <hr/>
                        <h2 className={classes.title}>StretchMasterP Articles</h2>
                        <div className={classes.root}>
                            {this.state.article_list.map((data, index) => (
                                <ArticleListItem key={index} data={data} onClicked={(e, data) => this.handleOpen(e, data)} ></ArticleListItem>
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
                        <h2 className={classes.title}>StretchMasterP Articles</h2>
                        <div className={classes.root}>
                            {this.state.article_list.map((data, index) => (
                                <ArticleListItem key={index} data={data} onClicked={(e, data) => this.handleOpen(e, data)} ></ArticleListItem>
                            ))}
                        </div>
                    </div>
                );
            }
        }

    }
}


export default withStyles(ArticleListStyle)(ArticleList);