
export const  AudioPlayerStyle = theme => ({
    audio:{
      backgroundColor: "#303030"
    },
    root: {
      display: 'flex',
    },
    title: {
      flexGrow: 1,
    },
   
    toolbarButtons: {
      marginLeft: 'auto',
    },
    content: {
      paddingTop: theme.spacing(2),
      flexGrow: 1,
      height: '90vh',
      overflow: 'auto',
    },
    container: {
      paddingBottom: theme.spacing(4),
      backgroundColor: "#303030"
    },
    paper: {
      padding: theme.spacing(2),
      display: 'flex',
      overflow: 'auto',
      flexDirection: 'column',
    },
    
    /*,
    //fixedHeight: {
    //  height: 240,
    },*/
  });