import { title,cardWrapTitle } from "assets/jss/material-kit-react.js";

export const ArticleListItemStyle = theme => ({
  root: {
    maxWidth: 400,
    minWidth: 400,
    margin:5,
    padding :5,
    marginBottom:20
  },
  contentRoot: {
   marginLeft:'45px',
   marginRight:'45px'
  },
  subtitle : {
    ...title,
    ...cardWrapTitle,
    margin: "0 0 20px 0",
    fontSize:"1.2rem",
  },

  listTitle : {
    color: "#3C4858",
    margin: "1.75rem 0 0.875rem",
    textDecoration: "none",
    fontWeight: "700",
    fontSize:"1.5rem",
    wordWrap: "break-word"
  },
  details: {
    display: 'flex',
    flexDirection: 'column',
  },
  content: {
    flex: '1 0 auto',
  },
  cover: {
    height: 0,
    paddingTop: '56.25%', // 16:9
   
  },
  controls: {
    display: 'flex',
    alignItems: 'center',
    paddingLeft: theme.spacing(1),
    paddingBottom: theme.spacing(1),
  },
  playIcon: {
    height: 38,
    width: 38,
  }
});