export const AudioListItemStyle = theme => ({
  root: {
    maxWidth: 200,
    minWidth: 200,
    margin:5,
    padding :5,
    marginBottom:20
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